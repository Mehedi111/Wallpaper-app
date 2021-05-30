import 'package:flutter/material.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/views/full_image_view.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: const <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black87)),
        TextSpan(text: 'Hub', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget wallpaperList({context, @required List<WallpaperModel> wallpaperList}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpaperList.map((e) {
        return GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(imageUrl: e.srcModel.portrait)));
              },
          child: Hero(
            tag: e.srcModel.portrait,
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(e.srcModel.portrait, fit: BoxFit.cover)),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
