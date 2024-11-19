class KotaModel {
  String? id;
  String? bpsKode;
  String? nama;
  String? lat;
  String? lng;
  String? provinsiId;

  KotaModel({
    this.id,
    this.bpsKode,
    this.nama,
    this.lat,
    this.lng,
    this.provinsiId,
  });

  KotaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bpsKode = json['bps_kode'];
    nama = json['nama'];
    lat = json['lat'];
    lng = json['lng'];
    provinsiId = json['provinsi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bps_kode'] = bpsKode;
    data['nama'] = nama;
    data['lat'] = lat;
    data['lng'] = lng;
    data['provinsi_id'] = provinsiId;
    return data;
  }

  
  static List<KotaModel> fromJsonList(List list) {
    return list.map((item) => KotaModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $nama';
  }

  bool isEqual(KotaModel model) {
    return id == model.id;
  }
}
