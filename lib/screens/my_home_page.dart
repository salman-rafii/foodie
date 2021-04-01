import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String allrest = 'See All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 350,
          height: 50,
          child: TextField(
            decoration: InputDecoration(
                icon: Icon(Icons.search),
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
                Icons.shopping_cart_sharp,
                color: Colors.green,
                size: 30,
              ),
              onPressed: null),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 70,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.home,
              size: 40,
              color: Colors.red,
            ),
            SizedBox(
              width: 40,
            ),
            Icon(
              Icons.favorite,
              size: 40,
              color: Colors.red,
            ),
            SizedBox(
              width: 140,
            ),
            Icon(
              Icons.notifications,
              size: 40,
              color: Colors.red,
            ),
            SizedBox(
              width: 40,
            ),
            Icon(
              Icons.person,
              size: 40,
              color: Colors.red,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.shopping_cart_rounded,
          size: 40,
          color: Colors.black45,
        ),
        onPressed: null,
      ),
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
                        'Trending Restaurants',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[400]),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                          onPressed: null,
                          child: Text(
                            'See All',
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
          CarouselSlider(
            options: CarouselOptions(height: 300, enableInfiniteScroll: false),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 1,
                    shadowColor: Colors.red,
                    child: Stack(
                      children: [
                        Card(
                          child: Text('OPEN'),
                        ),
                        Positioned(
                          child: Image.network(
                              'https://raw.githubusercontent.com/JideGuru/FlutterFoodybite/master/ss/1.png'),
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
                        'Categories',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[400]),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                          onPressed: null,
                          child: Text(
                            'See All',
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
          CarouselSlider(
            options: CarouselOptions(enableInfiniteScroll: false),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 100,
                    width: 300,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 1,
                      shadowColor: Colors.red,
                      child: Stack(),
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
