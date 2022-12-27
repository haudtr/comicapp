class nd {
  String anh;

  nd({required this.anh});
  factory nd.fromJson(Map<String, dynamic> obj) {
    return nd(anh: obj['anh']);
  }
}

class ChapterModel {
  String id;
  String maTruyen;
  String tenTruyen;
  int tapSo;
  String ten;
  DateTime ngayDang;
  List<dynamic> noiDung;

  ChapterModel(
      {required this.id,
      required this.maTruyen,
      required this.tenTruyen,
      required this.tapSo,
      required this.ten,
      required this.ngayDang,
      required this.noiDung});

  factory ChapterModel.fromJson(Map<String, dynamic> obj) {
    return ChapterModel(
      id: obj['id'],
      maTruyen: obj['maTruyen'],
      tenTruyen: obj['tenTruyen'],
      tapSo: int.parse(obj['tapSo'].toString()),
      ten: obj['ten'],
      ngayDang: DateTime.parse(obj['ngayDang']),
      noiDung: obj['noiDung'].map((e) {
        return nd.fromJson(e);
      }).toList(),
    );
  }
}
