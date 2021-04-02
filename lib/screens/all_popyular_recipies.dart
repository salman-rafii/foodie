import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'details_recipie.dart';

class AllRecipiesWidget extends StatefulWidget {
  @override
  _AllRecipiesWidgetState createState() => _AllRecipiesWidgetState();
}

class _AllRecipiesWidgetState extends State<AllRecipiesWidget> {
  @override
  void initState() {
    getPersons();
    getAllFvrt();
    print('fvrt list $fvrtlist');
    super.initState();
  }

  void markFav(String id) async {
    print('callling markfvr');
    List<String> favt = [];
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.containsKey('favrt'));
    if (!_pref.containsKey('favrt')) {
      print('No favrt found');
      favt.add(id);
    } else {
      print('Favrt found');
      favt = _pref.getStringList('favrt');
      print('favrt are $favt');
      favt.add(id);
      print('favrt has added to list $favt');
    }
    print('setting value to sharedprefrrenece');
    _pref.setStringList('favrt', favt);
    print('values has been set');
  }

  List<dynamic> fvrtlist = [];
  void getAllFvrt() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    fvrtlist = _pref.getStringList('favrt');
  }

  bool checfvrt(String id) {
    print(fvrtlist);
    if (fvrtlist.contains(id)) {
      print('fvrt found');
      return true;
    } else {
      print('fvrt not found');
      return false;
    }
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
        print('Satus Code of TrendingMovies is Not 200');
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
          title: Text(
            'Foodie App',
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   height: 50,
          //   child: TextField(
          //     decoration: InputDecoration(
          //         hintText: 'Search Here',
          //         enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10.0))),
          //   ),
          // ),
          centerTitle: true,
          // actions: [
          //   Icon(
          //     Icons.search,
          //     color: Colors.black,
          //   ),
          //   SizedBox(
          //     width: 15,
          //   )
          // ],
          backgroundColor: Colors.white,
        ),
        // bottomNavigationBar: Container(
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
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[100],
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Popular Recipies Are Here',
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
                Column(
                    children: popular_recipie
                        .map(
                          (e) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Stack(
                              children: [
                                Image.network(
                                  e['image'],
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  bottom: 100,
                                  left: 100,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetialsPage(
                                                  e['id'].toString())));
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
                                  ),
                                ),
                                Positioned(
                                    right: 5,
                                    child: IconButton(
                                        icon: checfvrt(e['id'].toString()) ==
                                                false
                                            ? Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                                size: 40,
                                              )
                                            : Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                        onPressed: () {
                                          print('clicked favrt button');
                                          print(e['id']);
                                          markFav(e['id'].toString());
                                        })),
                                Positioned(
                                  bottom: 0,
                                  child: Card(
                                    child: Text(
                                      e['title'],
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50)
                              ],
                            ),
                          ),
                        )
                        .toList())
                //               (e) => SingleChildScrollView(
                //                 child: Card(
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(20)),
                //                   elevation: 1,
                //                   shadowColor: Colors.red,
                //                   child: Stack(
                //                     children: [
                //                       Positioned(
                //                         child: Image.network(
                //                           e['image'],
                //                           fit: BoxFit.contain,
                //                         ),
                //                       ),
                //                       Positioned(
                //                         bottom:
                //                             MediaQuery.of(context).size.height * 0.1,
                //                         left:
                //                             MediaQuery.of(context).size.width * 0.24,
                //                         child: RaisedButton(
                //                           child: Text(
                //                             'See Details',
                //                             style: TextStyle(
                //                                 color: Colors.white,
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 20),
                //                           ),
                //                         ),
                //                       ),
                //                       Positioned(
                //                         child: Card(
                //                           child: Text(
                //                             e['title'],
                //                             style: TextStyle(
                //                               color: Colors.red,
                //                               fontSize: 20,
                //                               fontWeight: FontWeight.bold,
                //                             ),
                //                             overflow: TextOverflow.ellipsis,
                //                           ),
                //                         ),
                //                         bottom:
                //                             MediaQuery.of(context).size.height * 0.02,
                //                         left:
                //                             MediaQuery.of(context).size.width * 0.02,
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             )
                //             .toList()),
                //   ],
                // ),

                // child: CarouselSlider(
                //   options: CarouselOptions(
                //       height: 300,
                //       enableInfiniteScroll: false,
                //       scrollDirection: Axis.vertical),
                //   items: popular_recipie.map((i) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         return Card(
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20)),
                //           elevation: 1,
                //           shadowColor: Colors.red,
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 child: Image.network(i['image']),
                //               ),
                //               Positioned(
                //                 bottom: MediaQuery.of(context).size.height * 0.16,
                //                 left: MediaQuery.of(context).size.width * 0.25,
                //                 // top: 0,
                //                 // right: 0,
                //                 child: RaisedButton(
                //                   child: Text(
                //                     'See Details',
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 20),
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 child: Text(
                //                   i['title'],
                //                   style: TextStyle(
                //                     color: Colors.red,
                //                     fontSize: 15,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                   overflow: TextOverflow.ellipsis,
                //                 ),
                //                 bottom: MediaQuery.of(context).size.height * 0.02,
                //                 left: MediaQuery.of(context).size.width * 0.02,
                //               )
                //             ],
                //           ),
                //         );
                //       },
                //     );
                //   }).toList(),
                // ),
              ]),
            )));
  }
}
