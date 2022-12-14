import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/favorite.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import '../constants/localhost.dart' as l;

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel> listFavoriteComic = [];
  List<FavoriteModel> listFavoriteComicUser = [];

  Future<void> getComicFavorite(String id) async {
    String apiURL = "http://${l.localhost}/api/v1/favorite/comic/$id";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var favoriteComicList = jsonObject as List;
    listFavoriteComic = favoriteComicList.map((e) {
      return FavoriteModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  Future<void> getComicFavoriteUser(String id) async {
    String apiURL = "http://${l.localhost}:3000/api/v1/favorite/account/${id}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var favoriteComicList = jsonObject as List;
    listFavoriteComicUser = favoriteComicList.map((e) {
      return FavoriteModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  Future<bool> like(String maTruyen, String tenTruyen, String maDocGia) async {
    final response = await http.post(
        Uri.parse('http://${l.localhost}:3000/api/v1/favorite/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "maTruyen": maTruyen,
            "tenTruyen": tenTruyen,
            "maDocGia": maDocGia
          },
        ));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unlike(String maTruyen, String maDocGia) async {
    final response = await http.post(
        Uri.parse('http://${l.localhost}:3000/api/v1/favorite/delete/unLike'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{"maTruyen": maTruyen, "maDocGia": maDocGia},
        ));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  bool checkFavorite(String maTruyen, String maDocGia) {
    for (var item in listFavoriteComic) {
      if (item.maTruyen == maTruyen && item.maDocGia == maDocGia) return true;
    }
    return false;
  }
}
