import 'package:flutter/material.dart';
import 'package:foodie/model/initialdata.dart';
import 'package:foodie/screens/login_page.dart';
import 'package:foodie/screens/my_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/details_recipie.dart';

Future<void> main() async {
  //cc487902683c4f9fb86a7c2295a4880d
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var session = prefs.getString('session');
  print('Session is $session');
  runApp(MaterialApp(
      home: session == null
          ? LoginPage()
          : MyHomePage())); //runApp(MyApp(session));
}

class MyApp extends StatelessWidget {
  var session;
  MyApp(this.session);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Foodie',
        theme: ThemeData(
          // This is the theme of your application.

          primarySwatch: Colors.blue,
        ),
        home: session == true ? MyHomePage() : LoginPage());
  }
}
