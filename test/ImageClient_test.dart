import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:load_images/models/ImageClient.dart';

import '../lib/models/ImageModel.dart';

main() {
  ImageClient api = new ImageClient();
  setUp(() async {
    api.client = MockClient((request) async {
      final file = new File("test_json.json");
      String jsonString = await file.readAsString();
      print(jsonString);
      return Response(jsonString, 200);
    });
  });

  test("load one image", () async {
    Response response = await api.getImage(0);
    var decodedJson = json.decode(response.body);
    ImageLoader loader = new ImageLoader.fromJson(decodedJson);
    expect("assets/test_image.png", loader.image);
    expect("test title", loader.title);
  });
}