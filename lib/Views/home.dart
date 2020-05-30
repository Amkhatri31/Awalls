import 'dart:convert';
import 'package:awalls/Views/search.dart';
import 'package:flutter/material.dart';
import 'package:awalls/Widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awalls/Model/catagories_model.dart';
import 'package:http/http.dart' as http;
import 'package:awalls/Data/data.dart';

import 'categories.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageNo = 1;
  List<Results> dataresult = [];
  List<CategoryModel> categories = [];
  TextEditingController textfeildController = TextEditingController();

  Future<Data> getPopularWall() async {
    if (pageNo <= 10) {
      var response = await http.get(
          'https://api.unsplash.com/search/photos?page=$pageNo&per_page=30&query=wallpapers&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
          headers: {"Authorization": apiKey});
      var jsonData = jsonDecode(response.body);
      var data = Data.fromJson(jsonData);
      dataresult = data.results;
      pageNo++;
      setState(() {});
    } else {
      pageNo = 1;
      var response = await http.get(
          'https://api.unsplash.com/search/photos?page=$pageNo&per_page=30&query=wallpapers&client_id=av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc',
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
    getPopularWall();
    categories=getCategories();
    super.initState();
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                      searchString: textfeildController.text,
                                    )));
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
                height: 16,
              ),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        title: categories[index].categoryName,
                        imgurl: categories[index].imgUrl,
                      );
                    }),
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

class CategoryTile extends StatelessWidget {
  final String imgurl, title;

  const CategoryTile({Key key, @required this.imgurl, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Category(categoryName: title.toLowerCase());
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgurl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: GoogleFonts.mcLaren(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
