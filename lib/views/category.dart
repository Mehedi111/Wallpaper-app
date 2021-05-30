
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/widgets/widget.dart';

class Category extends StatefulWidget {
  final String categoryName;

  Category({@required this.categoryName});

  @override
  _CategoryState createState() => _CategoryState();
}


class _CategoryState extends State<Category> {

  List<WallpaperModel> wallpapers = [];

  getCategoryWallpapers(query) async {
    wallpapers.clear();
    String defaultUrl = "https://api.pexels.com/v1/search?query=$query&per_page=10";
    var response = await get(Uri.parse(defaultUrl), headers: {"Authorization": api_key});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      WallpaperModel model = WallpaperModel.fromMap(element);
      wallpapers.add(model);
      print(element);
    });

    setState(() {});
  }

  @override
  void initState() {
    getCategoryWallpapers(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 16),
              wallpaperList(wallpaperList: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}

