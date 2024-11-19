class ProvinsiModel {
  String? id;
  String? nama;
  String? lat;
  String? lng;

  ProvinsiModel({
    this.id,
    this.nama,
    this.lat,
    this.lng,
  });

  ProvinsiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  
  static List<ProvinsiModel> fromJsonList(List list) {
    return list.map((item) => ProvinsiModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $nama';
  }

  bool isEqual(ProvinsiModel model) {
    return id == model.id;
  }
}
