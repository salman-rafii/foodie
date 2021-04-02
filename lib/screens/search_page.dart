import 'package:flutter/material.dart';
import 'package:foodie/screens/details_recipie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  String type;
  SearchPage(this.type);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller;
  @override
  void initState() {
    getSearchResults(widget.type);
    _controller = TextEditingController();
    print(widget.type); // TODO: implement initState
    super.initState();
  }

  List<dynamic> singleResults = [];
  List<dynamic> serachresults = [];
  int counter = 0;
  void getSearchResults(String query) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          'https://api.spoonacular.com/recipes/autocomplete?number=10&query=${query}&apiKey=cc487902683c4f9fb86a7c2295a4880d'));

      if (response.statusCode == 200) {
        var body = response.body;

        var mapp = json.decode(body);
        serachresults = mapp;
        print('Matched Movies');
        print(serachresults.length);
        setState(() {});
      } else {
        print('Satus Code of Serach is Not 200');
      }
    } catch (Expception) {
      print('Exception of Error in getting Serach Data....See Below');
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
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        title: Container(
          width: 350,
          height: 50,
          child: TextField(
            onChanged: (data) {
              print('Changed String is : $data');
              getSearchResults(data.toString());
              // setState(() {});
            },
            onSubmitted: (data) {
              getSearchResults(data.toString());
              _controller.clear();

              print('Submitted String is: $data');
            },
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'Search Here',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              getSearchResults(_controller.text.toString());
            },
            child: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 20))
        ],
      ),
      body: serachresults == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                children: serachresults
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetialsPage(e['id'].toString())));
                        },
                        child: ListTile(
                          title: Text(e['title']),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
