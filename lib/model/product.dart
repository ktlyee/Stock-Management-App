class Product {
  String documentId = '';
  String productId = '';
  String name = '';
  String price = '0.00';
  String detail = '';
  String cost = '0.00';
  String amount = '0.00';
  String image = '';

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
      'image': image
    };
  }
}
