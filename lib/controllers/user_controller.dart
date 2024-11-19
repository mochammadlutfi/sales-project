import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:pds/models/provinsi_model.dart';
import '../../../core/core_export.dart';
import '../core/cache_manager.dart';
import '../models/dapil_model.dart';
import '../models/user_model.dart';

class UserController extends GetxController with CacheManager{
  TextEditingController nikC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  RxString jkC = "".obs;
  TextEditingController tmpLahirC = TextEditingController();
  TextEditingController rtC = TextEditingController();
  TextEditingController rwC = TextEditingController();
  TextEditingController tpsC = TextEditingController();
  Rx<ProvinsiModel> provinsi = ProvinsiModel().obs;
  Rx<KotaModel> kota = KotaModel().obs;
  Rx<KecamatanModel> kecamatan = KecamatanModel().obs;
  Rx<KelurahanModel> kelurahan = KelurahanModel().obs;
  File? avatar;
  Rx<DateTime> tglLahirC = DateTime.now().obs;

  
  TextEditingController targetC = TextEditingController();
  TextEditingController nomorC = TextEditingController();
  RxString level = "".obs;
  RxString dapilDaerah = "".obs;
  Rx<DapilModel> dapil = DapilModel().obs;

  
  UserModel user = UserModel();

  Future<void> updateProfile() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/profile/update';
    Map<String, dynamic> data = {
        "nik": nikC.text,
        "nama": namaC.text,
        "jk": jkC,
        "tmp_lahir": tmpLahirC.text,
        "tgl_lahir" : DateFormat('yyyy-MM-dd').format(tglLahirC.value),
        "phone" : phoneC.text,
        "email" : emailC.text,
        "alamat" : alamatC.text,
        "rt" : rtC.text,
        "rw" : rwC.text,
        "tps" : tpsC.text,
        "kota_id" : kota.value.id,
        "kec_id" : kecamatan.value.id,
        "kel_id" : kelurahan.value.id,
    };

    if(avatar != null){
      if (avatar == null) return;
      File image = File(avatar!.path);
      String avatarName = image.path.split('/').last;
      data["image"] = await MultipartFile.fromFile(avatar!.path, filename: avatarName);
    }
    
    var formData = FormData.fromMap(data);
    try {
      final Response response = await apiClient.postSecure(url: url, data : formData);
      if(response.data['result'] == true){
        saveUser(UserModel.fromJson(response.data['user']));
        // getUser();
        AppHelper().hideLoading();
        Get.back(result: true);
      }
      // AppHelper.loggerNoStack.v(e);
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
  }

  
  Future<void> getProfile() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/profile';
    try {
      final Response response = await apiClient.getSecure(url: url);
      user = UserModel.fromJson(response.data["data"]);
      namaC.text = user.name ?? "";
      phoneC.text = user.phone ?? "";
    } catch (e) {
      user = UserModel();
    }
    update();
  }
  
  Future<void> updatePassword(String oldPassword, String password) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/profile/password';
    var formData = FormData.fromMap({
      'old_password' : oldPassword,
      'password' : password
    });
    try {
      final Response response = await apiClient.postSecure(url: url, data : formData);
      if(response.data['result'] == true){
        AppHelper().hideLoading();
        Get.back(result: true);
        AppHelper.showSnackbar("success", response.data['message'], SnackPosition.BOTTOM);
      }else{
        AppHelper.showSnackbar("error", response.data['message'], SnackPosition.BOTTOM);
      }
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
  }

}