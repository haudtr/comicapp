import 'dart:convert';
import 'dart:io';
import 'package:comic_app/models/comic.dart';
import 'package:comic_app/models/user.dart';
import 'package:comic_app/signup.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import '../constants/localhost.dart' as l;

class UserProvider extends ChangeNotifier {
  List<UserModel> list = [];
  bool iSignUp = true;
  bool iLogIn = true;

  // Future<void> getAccount(String ID) async {
  //   String apiURL = "http://localhost:3000/api/v1/account/${ID}";
  //   var client = http.Client();
  //   var jsonString = await client.get(Uri.parse(apiURL));
  //   var jsonObject = jsonDecode(jsonString.body);
  //   var accountObject = jsonObject;
  //   account = accountObject;
  //   notifyListeners();
  // }

  Future<void> getUser(String email) async {
    String apiURL = "http://${l.localhost}/api/v1/account/user/${email}";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    // var comiclistObject = jsonObject;

    constant.user = UserModel(
        id: jsonObject[0]['id'],
        email: jsonObject[0]['email'],
        password: jsonObject[0]['password'],
        phoneNumber: jsonObject[0]['phoneNumber'],
        avatar: jsonObject[0]['avatar'],
        tenUser: jsonObject[0]['tenUser']);
    print(constant.user);
    notifyListeners();
  }

  Future<bool> signUpAccount(
      String tenUser, String email, String phone, String password) async {
    final response =
        await http.post(Uri.parse('http://${l.localhost}/api/v1/account/add'),
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

  Future<bool> loginAccount(String email, String password) async {
    final response =
        await http.post(Uri.parse('http://${l.localhost}/api/v1/account/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              <String, dynamic>{"email": email, "password": password},
            ));
    if (response.statusCode == 200) {
      iLogIn = true;
      return true;
    } else {
      iLogIn = false;
      return false;
    }
  }
}
