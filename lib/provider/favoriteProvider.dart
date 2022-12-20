import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/favorite.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel> listFavoriteComic = [];

  Future<void> getComicFavorite(String id) async {
    String apiURL = "http://localhost:3000/api/v1/favorite/comic/${id}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var favoriteComicList = jsonObject as List;
    listFavoriteComic = favoriteComicList.map((e) {
      return FavoriteModel.fromJson(e);
    }).toList();
    notifyListeners();
  }
}
