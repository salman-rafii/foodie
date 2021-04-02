import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

import 'favourite.dart';
import 'my_home_page.dart';

class DetialsPage extends StatefulWidget {
  String index;
  DetialsPage(this.index);
  @override
  _DetialsPageState createState() => _DetialsPageState();
}

class _DetialsPageState extends State<DetialsPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    getRecipieSearch(widget.index);
    _tabController = new MotionTabController(initialIndex: 1, vsync: this);
    super.initState();
  }

  MotionTabController _tabController;
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
        //ing = mapp['ingredients'];
        ing = data['extendedIngredients'];

        setState(() {});
        // print(ing[0]['id']);
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
          'View Details',
          style: TextStyle(
              color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      data['title'].toString(),
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shadowColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.network('${data['image']}'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Wrap(
                    children: [
                      ExpansionTile(title: Text("Summary"), children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Html(
                            data: "${data['summary']}",
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey[100],
                          title: Text('Ingredients'),
                          childrenPadding: EdgeInsets.all(2),
                          tilePadding: EdgeInsets.all(2),
                          expandedAlignment: Alignment.centerLeft,
                          children: ing
                              .map((e) => ListTile(
                                    title: Text(e['name'].toUpperCase()),
                                    subtitle: Text(e['amount'].toString() +
                                        '  ' +
                                        e['unit'].toString()),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
