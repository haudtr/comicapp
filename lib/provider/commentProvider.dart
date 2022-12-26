import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import '../constants/localhost.dart' as l;

class CommentProvider extends ChangeNotifier {
  List<CommentModel> listComicComment = [];
  Future<void> getCommentComic(String id) async {
    String apiURL = "http://${l.localhost}/api/v1/comment/chapter/${id}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var obj = jsonObject as List;
    listComicComment = obj.map((e) {
      return CommentModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  Future<bool> commentChapter(
      String maDocGia, String tenDocGia, String maTap, String noiDung) async {
    final response =
        await http.post(Uri.parse('http://${l.localhost}/api/v1/comment/add'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              <String, dynamic>{
                "maDocGia": maDocGia,
                "tenDocGia": tenDocGia,
                "maTap": maTap,
                "noiDung": noiDung
              },
            ));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
