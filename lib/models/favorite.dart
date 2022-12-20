class FavoriteModel {
  String id;
  String maTruyen;
  String tenTruyen;
  String maDocGia;
  FavoriteModel(
      {required this.id,
      required this.maTruyen,
      required this.tenTruyen,
      required this.maDocGia});

  factory FavoriteModel.fromJson(Map<String, dynamic> obj) {
    return FavoriteModel(
        id: obj['id'],
        maTruyen: obj['maTruyen'],
        tenTruyen: obj['tenTruyen'],
        maDocGia: obj['maDocGia']);
  }
}
