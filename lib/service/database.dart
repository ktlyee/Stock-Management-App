import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc344_project/model/product.dart';
import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

// class Database {
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   Stream<List<Income>> get incomes {
//     return firebaseFirestore
//         .collection('November')
//         .orderBy('day', descending: false)
//         .limitToLast(3)
//         .snapshots()
//         .map((event) => event.docs
//             .map((DocumentSnapshot<Map<String, dynamic>> snapshot) => Income(
//                 day: snapshot.data()!['day'],
//                 totalIncome: snapshot.data()!['totalIncome']))
//             .toList());
//   }
// }

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

Future<void> getSoldItems(SoldItemsNotifier soldItemsNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
      .collection('November')
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
}

uploadProductAndImage(
    Product product, bool isUpdating, Function productUploaded) async {
  // if (localFile != null) {
  //   var fileExtension = path.extension(localFile.path);
  //   var uuid = Uuid().v4();

  //   final Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('products/$uuid$fileExtension');

  //   await firebaseStorageRef.putFile(localFile).catchError((onError) {
  //     print(onError);
  //     return false;
  //   });

  //   String imageUrl = await firebaseStorageRef.getDownloadURL();

  //   _uploadProduct(product, isUpdating, productUploaded, imageUrl);
  // } else {
  //   String imageUrl = '';
  //   _uploadProduct(product, isUpdating, productUploaded, imageUrl);
  // }
  String imageUrl = '';
  _uploadProduct(product, isUpdating, productUploaded, imageUrl);
}

_uploadProduct(Product product, bool isUpdating, Function productUploaded,
    String imageUrl) async {
  CollectionReference productRef = firebaseFirestore.collection('products');

  if (imageUrl != '') {
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
