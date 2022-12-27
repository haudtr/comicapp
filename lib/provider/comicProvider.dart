import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/comic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../constants/localhost.dart' as l;

class ComicProvider extends ChangeNotifier {
  List<ComicModel> list = [];
  List<ComicModel> listSearch = [];

  List<ComicModel> listTop5 = [];
  List<ComicModel> comicID = [];

  Future<void> getList() async {
    String apiURL = "http://${l.localhost}/api/v1/comic";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var comiclistObject = jsonObject as List;
    list = comiclistObject.map((e) {
      return ComicModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  Future<void> getTopList() async {
    String apiURL = "http://${l.localhost}/api/v1/comic/top";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var comiclistObject = jsonObject as List;
    listTop5 = comiclistObject.map((e) {
      return ComicModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  Future<void> getComicID(String ID) async {
    String apiURL = "http://${l.localhost}/api/v1/comic/${ID}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var comiclistObject = jsonObject as List;
    comicID = comiclistObject.map((e) {
      return ComicModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  void searchComic(String input) {
    listSearch = list
        .where((e) =>
            e.tenTruyen.toString().toLowerCase().contains(input.toLowerCase()))
        .toList();
  }
}
