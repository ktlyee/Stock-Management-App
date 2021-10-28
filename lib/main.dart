import 'package:csc344_project/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(0xFF512DA8)
      ),
      home: NavigationBar(),
    );
  }
}