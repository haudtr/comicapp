class RatingModel {
  String id;
  String maDocGia;
  String avtDocGia;
  String maTruyen;
  int rate;
  String noiDung;
  DateTime ngayViet;

  RatingModel(
      {required this.id,
      required this.maDocGia,
      required this.avtDocGia,
      required this.maTruyen,
      required this.rate,
      required this.noiDung,
      required this.ngayViet});

  factory RatingModel.fromJson(Map<String, dynamic> obj) {
    return RatingModel(
        id: obj['id'],
        maDocGia: obj['maDocGia'],
        avtDocGia: obj['avtDocGia'],
        maTruyen: obj['maTruyen'],
        rate: obj['rate'],
        noiDung: obj['noiDung'],
        ngayViet: DateTime.parse(obj['ngayViet']));
  }
}
