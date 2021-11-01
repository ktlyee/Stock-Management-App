import 'dart:collection';

import 'package:csc344_project/model/soldItem.dart';
import 'package:flutter/material.dart';

class SoldItemsNotifier with ChangeNotifier {
  List<SoldItem> _soldList = [];

  UnmodifiableListView<SoldItem> get soldList =>
      UnmodifiableListView(_soldList);

  set soldList(List<SoldItem> soldList) {
    _soldList = soldList;
    notifyListeners();
  }
}
