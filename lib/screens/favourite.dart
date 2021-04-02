import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'details_recipie.dart';
import 'login_page.dart';
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
    //print('fvrt list $fvrtlist');
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

  void markFav(int id) async {
    print('callling markfvr');

    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.containsKey('favrt'));
    if (_pref.containsKey('favrt')) {
      setState(() {
        id--;
        var list = _pref.getStringList('favrt');
        print("adkdlkankas ${list.length}");
        list.removeAt(id);
        _pref.remove('favrt');
        _pref.setStringList('favrt', list);
        fvrtlist.clear();
        getAllFvrt();
        setState(() {});
      });
    }
  }

  var ing = [];
  Map<String, dynamic> data;
  void getRecipieSearch(String index) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          'https://api.spoonacular.com/recipes/${index}/information?apiKey=cc487902683c4f9fb86a7c2295a4880d'));
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MultiLevelDrawer(
        backgroundColor: Colors.white,
        rippleColor: Colors.red,
        subMenuBackgroundColor: Colors.grey.shade100,
        header: Container(
          // Header for Drawer
          height: size.height * 0.25,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/logo.jpg",
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome To RecipieMania",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ),
        ),
        children: [
          // Child Elements for Each Drawer Item
          MLMenuItem(
            content: Text("My Profile"),
            onClick: null,
            leading: Icon(Icons.person),
          ),
          MLMenuItem(
            content: Text("Settings"),
            onClick: null,
            leading: Icon(Icons.settings),
          ),
          MLMenuItem(
            content: Text("About US"),
            onClick: null,
            leading: Icon(Icons.notifications),
          ),
          MLMenuItem(
            content: Text("Logout"),
            onClick: () async {
              SharedPreferences _pref = await SharedPreferences.getInstance();
              _pref.remove('session');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            leading: Icon(Icons.logout),
          ),
        ],
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
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
        labels: ["Favourite", "Home"],
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
            // if (value == 2) {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => AccountScreen()));
            // }
            if (value == 1) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            }
            _tabController.index = value;
          });
        },
        icons: [Icons.favorite, Icons.home],
        textStyle: TextStyle(color: Colors.red),
      ),
      body: ing.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                  itemCount: fvrtlist.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 1,
                      shadowColor: Colors.red,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Image.network(ing[index]['image']),
                          ),
                          Positioned(
                              right: 5,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    print('clicked favrt button');
                                    print(index);
                                    markFav(index);
                                    //setState(() {});
                                  })),
                          Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.14,
                              left: MediaQuery.of(context).size.width * 0.35,
                              // top: 0,
                              // right: 0,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetialsPage(
                                              ing[index]['id'].toString())));
                                },
                                child: Text('See Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(50)),
                              )
                              // child: RaisedButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 DetialsPage(i['id'].toString())));
                              //   },
                              //   child: Text(
                              //     'See Details',
                              //     style: TextStyle(
                              //         color: Colors.white,
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 20),
                              //   ),
                              // ),
                              ),
                          Positioned(
                            child: Card(
                              child: Text(
                                ing[index]['title'],
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            bottom: MediaQuery.of(context).size.height * 0.02,
                            left: MediaQuery.of(context).size.width * 0.02,
                          )
                        ],
                      ),
                    );
                    // return Slidable(
                    //   key: ValueKey(123),
                    //   child: Card(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     color: Colors.teal[400],
                    //     child: SizedBox(
                    //       height: 100,
                    //       child: ListTile(
                    //         isThreeLine: true,
                    //         title: Text(
                    //           ing[index]['title'].toString(),
                    //           overflow: TextOverflow.ellipsis,
                    //           style: TextStyle(
                    //               color: Colors.redAccent,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //         subtitle: ing[index]['cuisines'] == null
                    //             ? Text("No Cuisines",
                    //                 style: TextStyle(color: Colors.white),
                    //                 overflow: TextOverflow.ellipsis)
                    //             : Text(ing[index]['cuisines'].toString(),
                    //                 style: TextStyle(color: Colors.white),
                    //                 overflow: TextOverflow.ellipsis),
                    //         leading: Card(
                    //           child: Image.network(ing[index]['image'].toString()),
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(10)),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   actionPane: SlidableDrawerActionPane(),
                    //   actions: [
                    //     Card(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           // print(
                    //           //     //'Selected List is ${listTask[index]}');
                    //         },
                    //         child: SizedBox(
                    //           height: 100.0,
                    //           child: Icon(
                    //             Icons.done_all_outlined,
                    //             size: 70,
                    //             color: Colors.red,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // );
                  }),
            ),
    );
  }
}
