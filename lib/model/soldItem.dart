class SoldItem {
  String date = '';
  int totalIncome = 0;
  int totalAmountSoldProducts = 0;
  List products = [];

  SoldItem();

  SoldItem.fromMap(Map<String, dynamic> data) {
    date = data['date'];
    totalIncome = data['totalIncome'];
    totalAmountSoldProducts = data['totalAmountSoldProducts'];
    products = data['products'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'totalIncome': totalIncome,
      'totalAmountSoldProducts': totalAmountSoldProducts,
      'products': products
    };
  }
}
