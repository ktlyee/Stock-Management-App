import 'dart:collection';

import 'package:csc344_project/model/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  // List<EachProductSold> _eachProductSold = [];
  List<Product> _productList = [];
  Product _currentProduct = Product();

  List<Map<String, dynamic>> amountOfProductSold = [];

  UnmodifiableListView<Product> get productList =>
      UnmodifiableListView(_productList);
  // UnmodifiableListView<EachProductSold> get eachProductSold =>
  //     UnmodifiableListView(_eachProductSold);

  Product get currentProduct => _currentProduct;

  set productList(List<Product> productList) {
    _productList = productList;
    notifyListeners();
  }

  // set eachProductSold(List<EachProductSold> productSoldInWeek) {
  //   _eachProductSold = productSoldInWeek;
  //   notifyListeners();
  // }

  set currentProduct(Product product) {
    _currentProduct = product;
    notifyListeners();
  }

  addProduct(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  getAmountProductSold(List amounts, String productName) {
    int totalAmount = 0;
    amounts.forEach((amount) {
      totalAmount += int.parse(amount);
    });

    amountOfProductSold
        .add({'product': productName, 'totalAmount': totalAmount});
    print(amountOfProductSold);
  }
}
