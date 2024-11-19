class CalegLevelModel {
  int? id;
  String? nama;

  CalegLevelModel({
    this.id,
    this.nama,
  });

  CalegLevelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    return data;
  }

  
  static List<CalegLevelModel> fromJsonList(List list) {
    return list.map((item) => CalegLevelModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $nama';
  }

  bool isEqual(CalegLevelModel model) {
    return id == model.id;
  }
}
