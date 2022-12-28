import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/chapter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import '../constants/localhost.dart' as l;

class ChapterProvider extends ChangeNotifier {
  List<ChapterModel> listChapterOfComic = [];
  ChapterModel chap = ChapterModel(
      id: "id",
      maTruyen: "maTruyen",
      tenTruyen: "tenTruyen",
      tapSo: 0,
      ten: "ten",
      ngayDang: DateTime(2022, 10, 12),
      noiDung: []);
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

  Future<void> getChap(String id, String chapter) async {
    String apiURL =
        "http://${l.localhost}:3000/api/v1/chapter/comic/${id}/${chapter}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    chap = ChapterModel(
      id: jsonObject['id'],
      maTruyen: jsonObject['maTruyen'],
      tenTruyen: jsonObject['tenTruyen'],
      tapSo: int.parse(jsonObject['tapSo'].toString()),
      ten: jsonObject['ten'],
      ngayDang: DateTime.parse(jsonObject['ngayDang']),
      noiDung: jsonObject['noiDung'].map((e) {
        return nd.fromJson(e);
      }).toList(),
    );
    notifyListeners();
  }
}
