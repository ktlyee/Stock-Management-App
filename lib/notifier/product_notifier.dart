import 'dart:collection';

import 'package:csc344_project/model/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  // List<EachProductSold> _eachProductSold = [];
  List<Product> _productList = [];
  Product _currentProduct = Product();

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
}
