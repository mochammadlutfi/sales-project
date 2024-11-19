class DukunganStatusModel {
  int? id;
  String? nama;

  DukunganStatusModel({
    this.id,
    this.nama,
  });

  DukunganStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    return data;
  }

  
  static List<DukunganStatusModel> fromJsonList(List list) {
    return list.map((item) => DukunganStatusModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $nama';
  }

  bool isEqual(DukunganStatusModel model) {
    return id == model.id;
  }
}
