import 'package:awalls/Views/image_view.dart';
import 'package:flutter/material.dart';
//import 'package:awalls/Views/image_view.dart';
import 'package:awalls/Data/data.dart';

Widget logoName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'A-', style: TextStyle(color: Colors.white)),
        TextSpan(text: 'Walls', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget wallpaperList({List<Results> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      shrinkWrap: true,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contxt) => ImageHome(
                    img: wallpaper.urls.regular,
                    fullimage:wallpaper.urls.regular,
                  ),
                ));
          },
          child: Hero(
            tag: wallpaper.urls.regular,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child:
                    Image.network(wallpaper.urls.small, fit: BoxFit.cover),
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
