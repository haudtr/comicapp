class CommentModel {
  String id;
  String maDocGia;
  String tenDocGia;
  String maTap;
  String noiDung;
  DateTime ngayBinhLuan;

  CommentModel(
      {required this.id,
      required this.maDocGia,
      required this.tenDocGia,
      required this.maTap,
      required this.noiDung,
      required this.ngayBinhLuan});

  factory CommentModel.fromJson(Map<String, dynamic> obj) {
    return CommentModel(
        id: obj['id'],
        maDocGia: obj['maDocGia'],
        tenDocGia: obj['tenDocGia'],
        maTap: obj['maTap'],
        noiDung: obj['noiDung'],
        ngayBinhLuan: DateTime.parse(obj['ngayBinhLuan']));
  }
}
