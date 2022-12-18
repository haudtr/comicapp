class ComicModel {
  String id;
  String tenTruyen;
  String tacGia;
  String nhanVatChinh;
  String moTa;
  String anhDaiDien;
  String anhBia;
  int luocXem;
  String status;

  ComicModel({
    required this.id,
    required this.tenTruyen,
    required this.tacGia,
    required this.nhanVatChinh,
    required this.moTa,
    required this.anhDaiDien,
    required this.anhBia,
    required this.luocXem,
    required this.status,
  });

  factory ComicModel.fromJson(Map<String, dynamic> obj) {
    return ComicModel(
      id: obj['id'],
      tenTruyen: obj['tenTruyen'],
      tacGia: obj['tacGia'],
      nhanVatChinh: obj['nhanVatChinh'],
      moTa: obj['moTa'],
      anhDaiDien: obj['anhDaiDien'],
      anhBia: obj['anhBia'],
      luocXem: obj['luocXem'],
      status: obj['status'],
    );
  }
}
