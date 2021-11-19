import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/widgets/bottom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        // StreamProvider<List<Income>>.value(
        //     value: Database().incomes, initialData: [])
        ChangeNotifierProvider(create: (context) => SoldItemsNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Roboto', primaryColor: Color(0xFF512DA8)),
      home: Container(
        child: NavigationBar(),
      ),
    );
  }
}
