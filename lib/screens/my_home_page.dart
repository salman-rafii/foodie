import 'dart:ui';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'account_box.dart';
import 'all_popyular_recipies.dart';
import 'category_wise_recipie.dart';

import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/TabItem.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

import 'details_recipie.dart';
import 'favourite.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    getPersons();
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
  var popular_recipie = [];
  void getPersons() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          'https://api.spoonacular.com/recipes/complexSearch?apiKey=5c070f1c48754e09aed8dc3a5c38c6a5'));
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

  MotionTabController _tabController;
  //String allrest = 'See All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Container(
          width: 350,
          height: 50,
          child: TextField(
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
              onPressed: null),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        labels: ["Favourite", "Home", "Account"],
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
      // Container(
      //   color: Colors.white,
      //   height: 70,
      //   child: Row(
      //     children: [
      //       SizedBox(
      //         width: 20,
      //       ),
      //       Icon(
      //         Icons.home,
      //         size: 40,
      //         color: Colors.red,
      //       ),
      //       SizedBox(
      //         width: 40,
      //       ),
      //       Icon(
      //         Icons.favorite,
      //         size: 40,
      //         color: Colors.red,
      //       ),
      //       SizedBox(
      //         width: 140,
      //       ),
      //       Icon(
      //         Icons.notifications,
      //         size: 40,
      //         color: Colors.red,
      //       ),
      //       SizedBox(
      //         width: 40,
      //       ),
      //       Icon(
      //         Icons.person,
      //         size: 40,
      //         color: Colors.red,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 5,
      //   backgroundColor: Colors.white,
      //   child: Icon(
      //     Icons.shopping_cart_rounded,
      //     size: 40,
      //     color: Colors.black45,
      //   ),
      //   onPressed: null,
      // ),
      body: Column(
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
                            fontWeight: FontWeight.bold,
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
                                    builder: (context) => AllRecipiesWidget()));
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
                  options:
                      CarouselOptions(height: 300, enableInfiniteScroll: false),
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
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.16,
                                  left:
                                      MediaQuery.of(context).size.width * 0.25,
                                  // top: 0,
                                  // right: 0,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetialsPage(
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
                                left: MediaQuery.of(context).size.width * 0.02,
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
                            fontWeight: FontWeight.bold,
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
                                    left:
                                        MediaQuery.of(context).size.width * 0.1,
                                    bottom: MediaQuery.of(context).size.height *
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
    );
  }
}
