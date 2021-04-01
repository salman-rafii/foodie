import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'account_box.dart';
import 'my_home_page.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  MotionTabController _tabController;
  void initState() {
    _tabController = new MotionTabController(initialIndex: 1, vsync: this);
    getAllFvrt();
    print('fvrt list $fvrtlist');
    super.initState();
  }

  List<dynamic> fvrtlist = [];
  void getAllFvrt() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    fvrtlist = _pref.getStringList('favrt');
    fvrtlist.forEach((element) {
      getRecipieSearch(element.toString());
    });
  }

  var ing = [];
  Map<String, dynamic> data;
  void getRecipieSearch(String index) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          'https://api.spoonacular.com/recipes/${index}/information?apiKey=5c070f1c48754e09aed8dc3a5c38c6a5'));
      print('Status Code is : ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Entered in Status 200');
        var body = response.body;

        var mapp = json.decode(body);
        data = mapp;
        ing.add(data);
        setState(() {});
        // print(ing[0]['id']);
      } else {
        print('Satus Code of gettingRecipie is Not 200');
        // MovieResponse.withError('Error in WithError');
      }
    } catch (Expception) {
      print('Exception of Error in getting PopularFood Data....See Below');
      print(Expception);
    }
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
                      'Favourite Recipies',
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
        initialSelectedTab: "Favourite",
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
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.builder(
            itemCount: fvrtlist.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(123),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.teal[400],
                  child: SizedBox(
                    height: 100,
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        ing[index]['title'].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: ing[index]['cuisines'] == null
                          ? Text("No Cuisines",
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis)
                          : Text(ing[index]['cuisines'].toString(),
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis),
                      leading: Card(
                        child: Image.network(ing[index]['image'].toString()),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                actionPane: SlidableDrawerActionPane(),
                actions: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // print(
                        //     //'Selected List is ${listTask[index]}');
                      },
                      child: SizedBox(
                        height: 100.0,
                        child: Icon(
                          Icons.done_all_outlined,
                          size: 70,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
