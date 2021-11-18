class Product {
  String documentId = '';
  String productId = '';
  String name = '';
  String price = '0.00';
  String detail = '';
  String cost = '0.00';
  String amount = '0.00';
  String image = '';
  String category = '';

  Product();

  Product.fromMap(Map<String, dynamic> data) {
    documentId = data['documentId'];
    productId = data['productId'];
    name = data['name'];
    price = data['price'];
    detail = data['detail'];
    cost = data['cost'];
    amount = data['amount'];
    image = data['image'];
    category = data['category'];
  }

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'productId': productId,
      'name': name,
      'price': price,
      'detail': detail,
      'cost': cost,
      'amount': amount,
      'image': image,
      'category': category
    };
  }
}

class EachProductSold {
  String date = '';
  int amount = 0;
  int totalPrice = 0;

  EachProductSold();

  Map<String, dynamic> toMap() {
    return {'date': date, 'amount': amount, 'totalPrice': totalPrice};
  }

  EachProductSold.fromMap(Map<String, dynamic> data) {
    date = data['date'];
    amount = data['amount'];
    totalPrice = data['totalPrice'];
  }
}
