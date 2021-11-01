class Product {
  String productId = '';
  String name = '';
  String price = '';
  String detail = '';
  String cost = '';
  String amount = '';
  String image = 'no image';

  Product();

  Product.fromMap(Map<String, dynamic> data) {
    productId = data['productId'];
    name = data['name'];
    price = data['price'];
    detail = data['detail'];
    cost = data['cost'];
    amount = data['amount'];
    image = data['image'];
  }
}
