class UserModel {
  String id;
  String tenUser;
  String email;
  String password;
  String phoneNumber;
  String avatar;

  UserModel(
      {required this.id,
      required this.tenUser,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> obj) {
    return UserModel(
        id: obj['id'],
        tenUser: obj['tenUser'],
        email: obj['email'],
        password: obj['password'],
        phoneNumber: obj['phoneNumber'],
        avatar: obj['avatar']);
  }
}
