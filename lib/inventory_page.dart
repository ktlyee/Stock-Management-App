import 'package:csc344_project/add_product.dart';
import 'package:csc344_project/product_detail_page.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Inventory',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              buildCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddProductPage(isUpdating: false),
                ),
              );
            },
            backgroundColor: CollectionsColors.yellow,
            child: Icon(
              Icons.add,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildCard() {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: productNotifier.productList.length,
        itemBuilder: (context, index) {
          final product = productNotifier.productList[index];
          return GestureDetector(
              onTap: () {
                productNotifier.currentProduct =
                    productNotifier.productList[index];
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InventoryDetailPage(),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: CollectionsColors.lightPurple,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: product.image != ''
                              ? NetworkImage(product.image)
                              : AssetImage('assets/images/vegetables.jpg')
                                  as ImageProvider,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '#${product.productId}',
                                  style: FontCollection.bodyPurpleTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  product.name,
                                  style: FontCollection.bodyBlackBoldTextStyle,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'see detail',
                                  style:
                                      FontCollection.underlineButtonTextStyle,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
