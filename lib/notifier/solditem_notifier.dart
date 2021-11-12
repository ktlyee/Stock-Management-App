import 'dart:collection';

import 'package:csc344_project/model/soldItem.dart';
import 'package:flutter/material.dart';

class SoldItemsNotifier with ChangeNotifier {
  List<SoldItem> _soldList = [];
  SoldItem _currentSoldItem = SoldItem();

  UnmodifiableListView<SoldItem> get soldList =>
      UnmodifiableListView(_soldList);

  SoldItem get currentSoldItem => _currentSoldItem;

  set soldList(List<SoldItem> soldList) {
    _soldList = soldList;
    notifyListeners();
  }

  set currentSoldItem(SoldItem soldItem){
    _currentSoldItem = soldItem;
    notifyListeners();
  }
}
