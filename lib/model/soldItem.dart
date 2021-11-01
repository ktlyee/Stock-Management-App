class SoldItem {
  String? date;
  int? totalIncome;

  SoldItem({this.date, this.totalIncome});

  SoldItem.fromMap(Map<String, dynamic> data) {
    date = data['date'];
    totalIncome = data['totalIncome'];
  }
}
