import 'dart:ffi';

class RatingModel {
  String id;
  String maDocGia;
  String tenDocGia;
  String avtDocGia;
  String maTruyen;
  double rate;
  String noiDung;
  DateTime ngayViet;

  RatingModel(
      {required this.id,
      required this.maDocGia,
      required this.tenDocGia,
      required this.avtDocGia,
      required this.maTruyen,
      required this.rate,
      required this.noiDung,
      required this.ngayViet});

  factory RatingModel.fromJson(Map<String, dynamic> obj) {
    return RatingModel(
        id: obj['id'],
        maDocGia: obj['maDocGia'],
        tenDocGia: obj['tenDocGia'],
        avtDocGia: obj['avtDocGia'],
        maTruyen: obj['maTruyen'],
        rate: double.parse(obj['rate'].toString()),
        noiDung: obj['noiDung'],
        ngayViet: DateTime.parse(obj['ngayViet']));
  }
}
