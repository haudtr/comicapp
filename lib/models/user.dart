class UserModel {
  String id;
  String email;
  String password;
  String phoneNumber;
  String avatar;
  String tenUser;
  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.avatar,
    required this.tenUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> obj) {
    return UserModel(
      id: obj['id'],
      email: obj['email'],
      password: obj['password'],
      phoneNumber: obj['phoneNumber'],
      avatar: obj['avatar'],
      tenUser: obj['tenUser'],
    );
  }
}
