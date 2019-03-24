import 'dart:core';

class ImageLoader {
  String id;
  String title;
  String image;

  ImageLoader(this.id, this.title, this.image);

  ImageLoader.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    image = json['url'];
  }
}
