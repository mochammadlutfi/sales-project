import 'kecamatan_model.dart';
import 'kota_model.dart';

class DapilModel {
  int? id;
  String? name;
  String? level;
  String? tipe;
  String? daerahId;
  String? kecamatanId;
  String? wilayah;
  int? tps;
  int? dpt;
  int? kursi;
  String? createdAt;
  String? updatedAt;
  String? tingkat;
  String? wilayahName;
  KotaModel? kota;
  KecamatanModel? kecamatan;

  DapilModel(
      {this.id,
      this.name,
      this.level,
      this.tipe,
      this.daerahId,
      this.kecamatanId,
      this.wilayah,
      this.tps,
      this.dpt,
      this.kursi,
      this.createdAt,
      this.updatedAt,
      this.tingkat,
      this.wilayahName,
      this.kota,
      this.kecamatan,
    });

  DapilModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    tipe = json['tipe'];
    daerahId = json['daerah_id'];
    kecamatanId = json['kecamatan_id'];
    wilayah = json['wilayah'];
    wilayahName = json['wilayah_name'];
    tps = json['tps'] != null ? int.parse(json['tps'].toString()) : null;
    dpt = json['dpt'] != null ? int.parse(json['dpt'].toString()) : null;
    kursi = json['kursi'] != null ? int.parse(json['kursi'].toString()) : null;
    tingkat = json['tingkat'];
    kota = json['kota'] != null ? KotaModel.fromJson(json['kota']) : null;
    kecamatan = json['kecamatan'] != null ? KecamatanModel.fromJson(json['kecamatan']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['level'] = level;
    data['tipe'] = tipe;
    data['daerah_id'] = daerahId;
    data['kecamatan_id'] = kecamatanId;
    data['wilayah'] = wilayah;
    data['tps'] = tps;
    data['dpt'] = dpt;
    data['kursi'] = kursi;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['tingkat'] = tingkat;
    data['wilayah_name'] = wilayahName;
    if (kota != null) {
      data['kota'] = kota!.toJson();
    }
    if (kecamatan != null) {
      data['kecamatan'] = kecamatan!.toJson();
    }
    return data;
  }


  static List<DapilModel> fromJsonList(List list) {
    return list.map((item) => DapilModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(DapilModel model) {
    return id == model.id;
  }

}