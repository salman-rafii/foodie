import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

import 'favourite.dart';
import 'my_home_page.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  MotionTabController _tabController;
  void initState() {
    _tabController = new MotionTabController(initialIndex: 1, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Container(
          margin: EdgeInsets.all(15),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Account Information',
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[400]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: MotionTabBar(
        labels: ["Favourite", "Home", "Account"],
        initialSelectedTab: "Account",
        tabIconColor: Colors.green,
        tabSelectedColor: Colors.red,
        onTabItemSelected: (int value) {
          print(value);
          setState(() {
            if (value == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FavouriteScreen()));
            }
            if (value == 2) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AccountScreen()));
            }
            if (value == 1) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            }
            _tabController.index = value;
          });
        },
        icons: [Icons.favorite, Icons.home, Icons.account_box],
        textStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
