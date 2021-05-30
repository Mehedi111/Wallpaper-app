class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel srcModel;

  WallpaperModel(
      {this.photographer,
      this.photographer_url,
      this.photographer_id,
      this.srcModel});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        photographer: jsonData['photographer'],
        photographer_id: jsonData['photographer_id'],
        photographer_url: jsonData['photographer_url'],
        srcModel: SrcModel.fromMap(jsonData['src']));
  }
}

class SrcModel {
  String portrait;
  String original;
  String small;
  String medium;

  SrcModel({this.portrait, this.original, this.small, this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData['original'],
      small: jsonData['small'],
      medium: jsonData['medium'],
      portrait: jsonData['portrait'],
    );
  }
}
