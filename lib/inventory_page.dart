import 'package:csc344_project/inventory_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';

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
              buildCard('#123456', 'Cabbage'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String productId, String productName) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InventoryDetailPage(),
            ),
          );
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: CollectionsColors.lightPurple,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/vegetables.jpg'),
                      // NetworkImage(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30,10,10,10),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            productId,
                            style: FontCollection.bodyPurpleTextStyle,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            productName,
                            style: FontCollection.bodyBlackBoldTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'see detail',
                            style: FontCollection.underlineButtonTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // child: ListTile(
          //   leading: Icon(Icons.album, size: 70),
          //   title: Text(
          //     productId,
          //     style: FontCollection.bodyPurpleTextStyle,
          //   ),
          //   subtitle: Text(
          //     productName,
          //     style: FontCollection.bodyBoldTextStyle,
          //   ),
          //   // trailing: Container(
          //   //   alignment: Alignment.bottomRight,
          //   //   child: TextButton(
          //   //     onPressed: () {},
          //   //     child: Text(
          //   //       'see detail',
          //   //       style: FontCollection.underlineButtonTextStyle,
          //   //     ),
          //   //   ),
          //   // ),
        ),
      ),
    );
  }
}
