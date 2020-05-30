import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageHome extends StatefulWidget {
  final String img;
  final String fullimage;
  ImageHome({@required this.img, @required this.fullimage});
  @override
  _ImageHomeState createState() => _ImageHomeState();
}

class _ImageHomeState extends State<ImageHome> {
  String _wallpaperStatus = "Initial";
  String _localfile;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Hero(
            tag: widget.img,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Image.network(widget.img, fit: BoxFit.cover),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    var permission =
                        await Permission.storage.request().isGranted;
                    print(permission);
                    var response = await http.get(widget.fullimage);
                    print(response.bodyBytes);
                    var res = Uint8List.fromList(response.bodyBytes);
                    print(res);
                    bool isDOne = await downloadImage(res);
                    final snackBar = SnackBar(
                      action: SnackBarAction(label: 'OK', onPressed: () {}),
                      content: Text(
                        'Downloaded',
                      ),
                    );
                    if (isDOne == true) {
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1c1b1b).withOpacity(0.8),
                        ),
                        height: 55.0,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 1.0),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [Color(0x36ffffff), Color(0x0fffffff)]),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Set Wallpaper",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                            Text(
                              "Image will be saved in gallery",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<bool> downloadImage(Uint8List image) async {
  final result = await ImageGallerySaver.saveImage(image);
  print(result);
  _localfile=result;
  return true;
}
}
