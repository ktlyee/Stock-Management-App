import 'dart:collection';

import 'package:csc344_project/model/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  List<Product> _productList = [];
  Product _currentProduct = Product();

  UnmodifiableListView<Product> get productList =>
      UnmodifiableListView(_productList);

  Product get currentProduct => _currentProduct;

  set productList(List<Product> productList) {
    _productList = productList;
    notifyListeners();
  }

  set currentProduct(Product product) {
    _currentProduct = product;
    notifyListeners();
  }
}
