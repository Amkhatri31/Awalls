import 'dart:convert';
import 'package:awalls/Data/data.dart';
import 'package:awalls/Widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchString;
  Search({this.searchString});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int pageNo = 1;
  List<Results> dataresult = [];
  TextEditingController textfeildController = TextEditingController();

  Future<Data> getSearchedWalls(String searchedItem) async {
    dataresult.clear();
    var response = await http.get(
        'https://api.unsplash.com/search/photos?page=1&per_page=100&query=$searchedItem&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
        headers: {"Authorization": apiKey});
    var jsonData = jsonDecode(response.body);
    var data = Data.fromJson(jsonData);
    dataresult = data.results;
    // dataresult=data.results;
    setState(() {});
  }

  Future<Data> getPopularWall() async {
    if (pageNo <= 10) {
      pageNo++;
      var response = await http.get(
          'https://api.unsplash.com/search/photos?page=$pageNo&per_page=30&query=${widget.searchString}&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
          headers: {"Authorization": apiKey});
      var jsonData = jsonDecode(response.body);
      var data = Data.fromJson(jsonData);
      dataresult = data.results;
      pageNo++;
      setState(() {});
    } else {
      pageNo = 1;
      var response = await http.get(
          'https://api.unsplash.com/search/photos?page=$pageNo&per_page=30&query=${widget.searchString}&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
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
    getSearchedWalls(widget.searchString);
    super.initState();
    textfeildController.text = widget.searchString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: logoName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(color: Colors.black),
                        ),
                        controller: textfeildController,
                        decoration: InputDecoration(
                          hintText: "Search Wallpapers",
                          hintStyle: GoogleFonts.mcLaren(
                            textStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getSearchedWalls(textfeildController.text);
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              wallpaperList(wallpapers: dataresult, context: context),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
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
