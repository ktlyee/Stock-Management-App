class SoldItem {
  String date = '';
  int totalIncome = 0;
  List<Map<String, dynamic>> products = [];

  SoldItem();

  SoldItem.fromMap(Map<String, dynamic> data) {
    date = data['date'];
    totalIncome = data['totalIncome'];
    // products = data['products'];
  }

  Map<String, dynamic> toMap() {
    return {'date': date, 'totalIncome': totalIncome, 'products': products};
  }
}
