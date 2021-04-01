import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetialsPage extends StatefulWidget {
  String index;
  DetialsPage(this.index);
  @override
  _DetialsPageState createState() => _DetialsPageState();
}

class _DetialsPageState extends State<DetialsPage> {
  @override
  void initState() {
    getRecipieSearch(widget.index);
    super.initState();
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
        title: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Search Here',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Colors.white,
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
                          color: Colors.red, fontWeight: FontWeight.bold),
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
