import 'package:flutter/material.dart';
import 'package:foodie/screens/login_page.dart';
import 'package:foodie/screens/my_home_page.dart';

import 'screens/details_recipie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      //MyHomePage(),
    );
  }
}
