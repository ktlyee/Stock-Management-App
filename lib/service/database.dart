import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc344_project/model/product.dart';
import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

Future<void> getSoldItems(
    SoldItemsNotifier soldItemsNotifier, String month) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
      .collection(month)
      .orderBy('date', descending: false)
      .limitToLast(7)
      .get();

  List<SoldItem> _soldItemList = [];
  snapshot.docs.forEach((document) {
    SoldItem soldItem = SoldItem.fromMap(document.data());
    _soldItemList.add(soldItem);
  });

  soldItemsNotifier.soldList = _soldItemList;
}

Future<void> getProducts(ProductNotifier productNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
      .collection('products')
      .orderBy('productId', descending: false)
      .get();

  List<Product> _productList = [];
  snapshot.docs.forEach((document) {
    Product product = Product.fromMap(document.data());
    _productList.add(product);
  });

  productNotifier.productList = _productList;

  _productList.forEach((product) {
    getEachSoldProduct(productNotifier, product.documentId, product.name);
  });
}

Stream<QuerySnapshot> getEachProductSold(String documentId) {
  return firebaseFirestore
      .collection('products')
      .doc(documentId)
      .collection('sold_products')
      .orderBy('date', descending: false)
      .limitToLast(7)
      .snapshots();
}

Future<void> getEachSoldProduct(
  ProductNotifier productNotifier,
  String docId,
  String productName,
) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
      .collection('products')
      .doc(docId)
      .collection('sold_products')
      .get();

  List _amountEachProduct = [];
  snapshot.docs.forEach((document) {
    _amountEachProduct.add(document.data()['amount'].toString());
  });

  productNotifier.getAmountProductSold(_amountEachProduct, productName);

  // List<EachProductSold> _eachProductSold = [];
  // snapshot.docs.forEach((document) {
  //   EachProductSold productSold = EachProductSold.fromMap(document.data());
  //   _eachProductSold.add(productSold);
  // });

  // productNotifier.eachProductSold = _eachProductSold;
}

// Add product
uploadProductAndImage(Product product, bool isUpdating,
    Function productUploaded, File? localFile) async {
  if (localFile != null) {
    var fileExtension = path.extension(localFile.path);
    var uuid = Uuid().v4();

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('products/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();

    _uploadProduct(product, isUpdating, productUploaded, imageUrl: url);
  } else {
    _uploadProduct(product, isUpdating, productUploaded);
  }
}

_uploadProduct(Product product, bool isUpdating, Function productUploaded,
    {String? imageUrl}) async {
  CollectionReference productRef = firebaseFirestore.collection('products');

  if (imageUrl != null) {
    product.image = imageUrl;
  }

  if (isUpdating) {
    await productRef.doc(product.documentId).update(product.toMap());
    productUploaded(product);
  } else {
    DocumentReference documentref = await productRef.add(product.toMap());

    product.documentId = documentref.id;
    await documentref.set(product.toMap(), SetOptions(merge: true));
    productUploaded(product);
  }
}

// Add sold products
addSoldProducts(SoldItem soldItem, String month) async {
  CollectionReference soldItemRef = firebaseFirestore.collection(month);

  DocumentReference documentRef = await soldItemRef.add(soldItem.toMap());
  await documentRef.set(soldItem.toMap(), SetOptions(merge: true));
}

addSoldProductInEachDocument(final soldProduct, String date) async {
  CollectionReference productRef = firebaseFirestore
      .collection('products')
      .doc(soldProduct['docId'])
      .collection('sold_products');

  DocumentReference documentRef = await productRef.add({
    'date': date,
    'amount': soldProduct['amount'],
    'totalPrice': soldProduct['totalPrice']
  });
}
