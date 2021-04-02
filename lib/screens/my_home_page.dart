import 'dart:ui';

import 'package:foodie/screens/search_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'all_popyular_recipies.dart';
import 'category_wise_recipie.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

import 'package:motion_tab_bar/MotionTabController.dart';

import 'package:motion_tab_bar/motiontabbar.dart';

import 'details_recipie.dart';
import 'favourite.dart';
import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  String title = "dshbdhjbjcdV";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    print('my homepage');
    getPersons();
    _controller = TextEditingController();
    _tabController = new MotionTabController(initialIndex: 1, vsync: this);

    super.initState();
  }

  List<dynamic> mealTypes = [
    {
      "name": "main course",
      "image":
          "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/partridge-in-cider-with-apples-celery-dd0f3c6.jpg"
    },
    {
      "name": "side dish",
      "image":
          "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/sticky-maple-roots-947d8f5.jpg"
    },
    {
      "name": "breakfast",
      "image":
          "https://i.pinimg.com/originals/d9/ae/39/d9ae39fc463a12df52f712e8f20d1bbd.jpg"
    },
    {
      "name": "salad",
      "image":
          "https://feelgoodfoodie.net/wp-content/uploads/2019/02/Mediterranean-Chopped-Salad-5-500x500.jpg"
    },
    {
      "name": "marinade",
      "image":
          "https://thestayathomechef.com/wp-content/uploads/2017/08/chicken-marinade-1.jpg"
    }
  ];
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _tabController.dispose();
  }

  var popular_recipie = [];
  void getPersons() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          'https://api.spoonacular.com/recipes/complexSearch?apiKey=cc487902683c4f9fb86a7c2295a4880d'));
      print('Status Code is : ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Entered in Status 200');
        var body = response.body;

        var mapp = json.decode(body);

        popular_recipie = mapp['results'];

        setState(() {});
        print(popular_recipie[0]['title']);
      } else {
        print('Satus Code of complexSearch is Not 200');
        // MovieResponse.withError('Error in WithError');
      }
    } catch (Expception) {
      print('Exception of Error in getting PopularFood Data....See Below');
      print(Expception);
    }
  }

  String search_query = '';
  TextEditingController _controller;
  MotionTabController _tabController;
  //String allrest = 'See All';
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
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.black,
        // ),
        title: Container(
          width: 350,
          height: 50,
          child: TextField(
            controller: _controller,
            onChanged: (data) {
              search_query = data;
            },
            onSubmitted: (data) {
              if (search_query.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(search_query)));
                _controller.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enter Some Characters')));
              }
            },
            decoration: InputDecoration(
                hintText: 'Search Here',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                print('Tapped on Search Button');
                if (search_query.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchPage(search_query)));
                  _controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Enter Some Characters')));
                }
              }),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        labels: [
          "Favourite",
          "Home",
        ],
        initialSelectedTab: "Home",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Popular Recipies',
                          style: TextStyle(
                              fontSize: 27,
                              //fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllRecipiesWidget()));
                            },
                            child: Text(
                              'See All (${popular_recipie.length})',
                              style: TextStyle(
                                color: Colors.blue[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            popular_recipie.isEmpty
                ? Center(child: CircularProgressIndicator())
                : CarouselSlider(
                    options: CarouselOptions(
                        height: 300, enableInfiniteScroll: false),
                    items: popular_recipie.take(5).map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 1,
                            shadowColor: Colors.red,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Image.network(i['image']),
                                ),
                                Positioned(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.16,
                                    left: MediaQuery.of(context).size.width *
                                        0.25,
                                    // top: 0,
                                    // right: 0,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetialsPage(
                                                        i['id'].toString())));
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
                                          borderRadius:
                                              BorderRadius.circular(50)),
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
                                  child: Text(
                                    i['title'],
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.02,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02,
                                )
                              ],
                            ),
                          );
                          // return Container(
                          //   height: 300,
                          //   width: MediaQuery.of(context).size.width * 1,
                          //   margin: EdgeInsets.only(right: 10),
                          //   decoration: BoxDecoration(color: Colors.amber,),

                          //   // child: Text(
                          //   //   'text $i',
                          //   //   style: TextStyle(fontSize: 16.0),
                          //   // ),
                          // );
                        },
                      );
                    }).toList(),
                  ),
            Container(
              margin: EdgeInsets.all(15),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Meal Types',
                          style: TextStyle(
                              fontSize: 27,
                              //fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            popular_recipie.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: mealTypes
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryRecipie(e['name'])));
                                  },
                                  child: Stack(children: [
                                    SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: Image.network(
                                        e['image'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          0.1,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Card(
                                        elevation: 4,
                                        shadowColor: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          e['name'].toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ))
                          .toList(),
                    ),
                  )
            // Container(
            //   height: 200,
            //   child: Expanded(
            //     child: PageView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 5,
            //       itemBuilder: (_, index) {
            //         return Card(
            //           child: Stack(
            //             fit: StackFit.passthrough,
            //             overflow: Overflow.visible,
            //             children: <Widget>[
            //               // Max Size Widget
            //               Container(
            //                 height: 300,
            //                 width: 400,
            //                 color: Colors.green,
            //                 child: Center(
            //                   child: Text(
            //                     'Top Widget: Green',
            //                     style:
            //                         TextStyle(color: Colors.white, fontSize: 20),
            //                   ),
            //                 ),
            //               ),
            //               Positioned(
            //                 top: 30,
            //                 right: 20,
            //                 child: Container(
            //                   height: 100,
            //                   width: 150,
            //                   color: Colors.blue,
            //                   child: Center(
            //                     child: Text(
            //                       'Middle Widget',
            //                       style: TextStyle(
            //                           color: Colors.white, fontSize: 20),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Positioned(
            //                 top: 30,
            //                 left: 20,
            //                 child: Container(
            //                   height: 100,
            //                   width: 150,
            //                   color: Colors.orange,
            //                   child: Center(
            //                     child: Text(
            //                       'Bottom Widget',
            //                       style: TextStyle(
            //                           color: Colors.white, fontSize: 20),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );

            // return Card(
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         child: Card(
            //           color: Colors.amber,
            //           child: Text('Open'),
            //         ),
            //       ),
            //       Positioned(
            //           child: Card(
            //         child: Text(
            //           'asknasjkna',
            //           style: TextStyle(),
            //         ),
            //       )),
            //     ],
            //   ),
            // );

            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
