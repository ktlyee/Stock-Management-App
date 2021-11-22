import 'dart:collection';

import 'package:csc344_project/model/product.dart';
import 'package:csc344_project/model/sales.dart';
import 'package:csc344_project/service/database.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  List<int> eachProductSold = [];
  List<String> _categoriesList = [];
  List<Product> _productList = [];
  Product _currentProduct = Product();

  List<Sales> amountOfProductSold = [];

  UnmodifiableListView<Product> get productList =>
      UnmodifiableListView(_productList);
  // UnmodifiableListView<int> get eachProductSold =>
  //     UnmodifiableListView(_eachProductSold);

  List<String> get categoriesList => _categoriesList;

  Product get currentProduct => _currentProduct;

  set productList(List<Product> productList) {
    _productList = productList;
    notifyListeners();
  }

  set categoriesList(List<String> categoriesList) {
    _categoriesList = categoriesList;
    notifyListeners();
  }

  set currentProduct(Product product) {
    _currentProduct = product;
    notifyListeners();
  }

  getEachProductSold(int amount) {
    eachProductSold.add(amount);
    print(eachProductSold);
    notifyListeners();
  }

  addProduct(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  getAmountProductSold(List amounts, String productName, String category) {
    int totalAmount = 0;
    amounts.forEach((amount) {
      totalAmount += int.parse(amount);
    });

    amountOfProductSold.add(
      Sales(productName, category, totalAmount),
    );

    amountOfProductSold.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
  }

  Future<void> reloadProductList(ProductNotifier productNotifier) async {
    getProducts(productNotifier);
    notifyListeners();
  }
}
