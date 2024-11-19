
class KelurahanModel {
  String? id;
  String? nama;
  String? bpsKode;
  String? kecamatanId;
  String? lat;
  String? lng;
  String? kodePos;

  KelurahanModel(
      {this.id,
      this.nama,
      this.bpsKode,
      this.kecamatanId,
      this.lat,
      this.lng,
      this.kodePos
    });

  KelurahanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    bpsKode = json['bps_kode'];
    kecamatanId = json['kecamatan_id'];
    lat = json['lat'];
    lng = json['lng'];
    kodePos = json['kode_pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['bps_kode'] = bpsKode;
    data['kecamatan_id'] = kecamatanId;
    data['lat'] = lat;
    data['lng'] = lng;
    data['kode_pos'] = kodePos;
    return data;
  }

  
  static List<KelurahanModel> fromJsonList(List list) {
    return list.map((item) => KelurahanModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $nama';
  }

  bool isEqual(KelurahanModel model) {
    return id == model.id;
  }

}
