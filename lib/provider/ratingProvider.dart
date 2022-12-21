import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/rating.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;

class RatingProvider extends ChangeNotifier {
  List<RatingModel> listRatingComic = [];
  Future<void> getComicRating(String id) async {
    String apiURL = "http://192.168.100.7:3000/api/v1/rate/comic/${id}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var ratingComicObject = jsonObject as List;
    listRatingComic = ratingComicObject.map((e) {
      return RatingModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  double getRate(List<RatingModel> list) {
    double total = 0;
    int n = list.length;
    for (var i = 0; i < n; i++) {
      total += list[i].rate;
    }

    return total / n;
  }
}
