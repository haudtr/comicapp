import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/comic.dart';
import 'package:comic_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  UserModel? account;
  bool iSignUp = true;

  Future<void> getAccount(String ID) async {
    String apiURL = "http://localhost:3000/api/v1/account/${ID}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var accountObject = jsonObject;
    account = accountObject;
    notifyListeners();
  }

  Future<bool> signUpAccount(
      String tenUser, String email, String phone, String password) async {
    final response =
        await http.post(Uri.parse('http://localhost:3000/api/v1/account/add'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              <String, dynamic>{
                "tenUser": tenUser,
                "email": email,
                "password": password,
                "phoneNumber": phone,
                "avatar":
                    "https://haycafe.vn/wp-content/uploads/2021/11/Anh-avatar-dep-chat-lam-hinh-dai-dien.jpg"
              },
            ));
    if (response.statusCode == 201) {
      iSignUp = true;
      return true;
    } else {
      iSignUp = false;
      return false;
    }
  }
}
