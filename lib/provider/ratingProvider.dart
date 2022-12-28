import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/rating.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import '../constants/localhost.dart' as l;

class RatingProvider extends ChangeNotifier {
  List<RatingModel> listRatingComic = [];
  Future<void> getComicRating(String id) async {
    String apiURL = "http://${l.localhost}/api/v1/rate/comic/${id}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var ratingComicObject = jsonObject as List;
    listRatingComic = ratingComicObject.map((e) {
      return RatingModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  Future<bool> rateComic(String maDocGia, String tenDocGia, String avatar,
      String maTruyen, double rate, String noiDung) async {
    final response =
        await http.post(Uri.parse('http://${l.localhost}:3000/api/v1/rate/add'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              <String, dynamic>{
                "maDocGia": maDocGia,
                "tenDocGia": tenDocGia,
                "avtDocGia": avatar,
                "maTruyen": maTruyen,
                "rate": rate,
                "noiDung": noiDung,
              },
            ));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editRateComic(String id, String maDocGia, String tenDocGia,
      String avatar, String maTruyen, double rate, String noiDung) async {
    final response = await http.put(
        Uri.parse('http://${l.localhost}:3000/api/v1/rate/edit/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "maDocGia": maDocGia,
            "tenDocGia": tenDocGia,
            "avtDocGia": avatar,
            "maTruyen": maTruyen,
            "rate": rate,
            "noiDung": noiDung,
            "ngayViet": DateTime.now().toString(),
          },
        ));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  String checkRating(String maTruyen, String maDocGia) {
    for (var item in listRatingComic) {
      if (item.maTruyen == maTruyen && item.maDocGia == maDocGia) {
        return item.id;
      }
    }
    return "";
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
