
class KecamatanModel {
  String? id;
  String? nama;
  String? kotaId;
  String? bpsKode;
  String? kodePos;
  String? lat;
  String? lng;

  KecamatanModel({
    this.id,
    this.nama,
    this.kotaId,
    this.bpsKode,
    this.kodePos,
    this.lat,
    this.lng
  });

  KecamatanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kotaId = json['kota_id'];
    bpsKode = json['bps_kode'];
    kodePos = json['kode_pos'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['kota_id'] = kotaId;
    data['bps_kode'] = bpsKode;
    data['kode_pos'] = kodePos;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
  
  static List<KecamatanModel> fromJsonList(List list) {
    return list.map((item) => KecamatanModel.fromJson(item)).toList();
  }

  String userAsString() {
    return '#$id $nama';
  }

  bool isEqual(KecamatanModel model) {
    return id == model.id;
  }
  
}
