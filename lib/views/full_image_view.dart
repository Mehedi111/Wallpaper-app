import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imageUrl;

  ImageView({this.imageUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imageUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imageUrl, fit: BoxFit.cover)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1C1B1B).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54, width: 1),
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [Color(0x36FFFFFF), Color(0x0FFFFFF)]),
                      ),
                      child: Column(
                        children: [
                          Text("Set Wallpaper",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70)),
                          Text("Image will be save in Gallery",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white70))
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 16),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Text("Cancel", style: TextStyle(color: Colors.white))),
                SizedBox(height: 50)
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    } else {
      /* PermissionStatus permission = */ await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}
