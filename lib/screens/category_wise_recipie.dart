import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details_recipie.dart';

class CategoryRecipie extends StatefulWidget {
  String type;
  CategoryRecipie(this.type);
  @override
  _CategoryRecipieState createState() => _CategoryRecipieState();
}

class _CategoryRecipieState extends State<CategoryRecipie> {
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

    setState(() {
      getAllFvrt();
    });
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
          'https://api.spoonacular.com/recipes/complexSearch?type=${widget.type}&apiKey=cc487902683c4f9fb86a7c2295a4880d'));
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
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
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
                              widget.type.toUpperCase(),
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
                                          setState(() {});
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
              ]),
            )));
  }
}
