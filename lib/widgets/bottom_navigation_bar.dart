import 'package:csc344_project/home_page.dart';
import 'package:csc344_project/inventory_page.dart';
import 'package:csc344_project/style/color.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const HomePage(),
    // const HomePage(),
    const InventoryPage(),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.list_alt),
    //   label: '',
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inbox),
      label: 'Inventory',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: CollectionsColors.yellow,
          child: Icon(
            Icons.list_alt,
            color: CollectionsColors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)
              ),
              color: CollectionsColors.deepPurple,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: _menuBar,
            currentIndex: _selectedIndex,
            selectedItemColor: CollectionsColors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: CollectionsColors.purple,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
