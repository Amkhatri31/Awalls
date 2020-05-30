import 'dart:convert';
import 'package:awalls/Data/data.dart';
import 'package:awalls/Widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final String categoryName;
  Category({this.categoryName});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int pageNo=1;
  List<Results> dataresult = [];

  Future<Data> getSearchedWalls(String searchedItem) async { 
    dataresult.clear();
    var response = await http.get(
        'https://api.unsplash.com/search/photos?page=1&per_page=100&query=$searchedItem&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
        headers: {"Authorization": apiKey});
        var jsonData=jsonDecode(response.body);
        var data=Data.fromJson(jsonData);
        dataresult=data.results;
    setState(() {
    });
  }

  Future<Data> getPopularWall() async {
    if (pageNo <= 10) {
      pageNo++;
      var response = await http.get(
          'https://api.unsplash.com/search/photos?page=$pageNo&per_page=30&query=${widget.categoryName}&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
          headers: {"Authorization": apiKey});
      var jsonData = jsonDecode(response.body);
      var data = Data.fromJson(jsonData);
      dataresult = data.results;
      pageNo++;
      setState(() {});
    } else {
      pageNo = 1;
      var response = await http.get(
          'https://api.unsplash.com/search/photos?page=$pageNo&per_page=30&query=${widget.categoryName}&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
          headers: {"Authorization": apiKey});
      var jsonData = jsonDecode(response.body);
      var data = Data.fromJson(jsonData);
      dataresult = data.results;
      print(dataresult.length);
      setState(() {});
    }
  }

  @override
  void initState() {
    getSearchedWalls(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: logoName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 8.0,
              ),
              wallpaperList(wallpapers: dataresult, context: context),
               Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 2.0,
                  color: Colors.blue,
                  onPressed: () {
                    getPopularWall();
                  },
                  child: Text(
                    'More',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
