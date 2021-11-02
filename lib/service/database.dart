import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc344_project/model/product.dart';
import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';

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
