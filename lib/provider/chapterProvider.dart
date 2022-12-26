import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/chapter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import '../constants/localhost.dart' as l;

class ChapterProvider extends ChangeNotifier {
  List<ChapterModel> listChapterOfComic = [];

  Future<void> getChapterOfComic(String id) async {
    String apiURL = "http://${l.localhost}/api/v1/chapter/comic/${id}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var chapterOfComicObject = jsonObject as List;
    listChapterOfComic = chapterOfComicObject.map((e) {
      return ChapterModel.fromJson(e);
    }).toList();
    // print(listChapterOfComic);
    notifyListeners();
  }
}
