import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:get_storage/get_storage.dart';
import '../../../core/core_export.dart';
import '../core/cache_manager.dart';
import '../models/user_model.dart';
import '../repositories/auth_repo.dart';

class AuthController extends GetxController with CacheManager {
  static final box = GetStorage();

  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  Rx<UserModel> user = UserModel().obs;
  
  UserModel? userModel;
  UserModel? get data => userModel;

  @override
  void onInit() {
    super.onInit();
    loginEmailController.text = '';
    loginPasswordController.text = '';

    newPasswordController.text = '';
    confirmNewPasswordController.text = '';
  }
  
  bool _isHidePassword = true;
  bool get isHidePassword => _isHidePassword;

  void toggleHidePassword() {
    _isHidePassword = !_isHidePassword;
    update();
  }

  Future<void> login() async {
    
    String url = '${AppConstants.appBaseUrl}/login';
    try {
      final Response response = await apiClient.post(url: url, data : {
        'username' : loginEmailController.text,
        'password' : loginPasswordController.text
      });
      UserModel data = UserModel.fromJson(response.data['result']);
      if(data.token != null){
        saveUser(data);
        saveToken(data.token);
        Get.offNamed('/');
      }else{
        Get.snackbar("Oops!",
            "Akun Kamu Tidak Ditemukan!",
            icon: const Icon(Icons.person, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 20, left: 14, right: 14),
            backgroundColor: AppStyles.colorDanger,
            colorText: AppStyles.colorWhite
          );
      }
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
    AppHelper().hideLoading();
  }

  // Future<void> login() async {
  //   try {
  //     final response = await AuthRepo.login(loginEmailController.text, loginPasswordController.text);
  //     AppHelper.loggerNoStack.v(response.toJson());
  //     if(response.token != null){
  //       saveUser(response);
  //       saveToken(response.token);
  //       Get.offNamed('/');
  //     }else{
  //       Get.snackbar("Oops!",
  //           "Akun Kamu Tidak Ditemukan!",
  //           icon: const Icon(Icons.person, color: Colors.white),
  //           snackPosition: SnackPosition.BOTTOM,
  //           margin: const EdgeInsets.only(bottom: 20, left: 14, right: 14),
  //           backgroundColor: AppStyles.colorDanger,
  //           colorText: AppStyles.colorWhite
  //         );
  //     }
  //   } catch (e) {
  //     AppHelper.loggerNoStack.v(e);
  //   }
  //   AppHelper().hideLoading();
  // }

  
  Future<void> updateUser() async {
    user.value = getUser();
    update();
  }


  Future<void> logout() async {
    try {
      final response = await AuthRepo.logout();
        AppHelper.loggerNoStack.v(response);
      if (response == true) {
          removeToken();
          Get.offNamed('/login');
      }else{
        
      }
    } catch (e) {
      // Log.loga(title, "getProducts:: e >>>>> $e");
      // setLoading(false);
      // constants.showSnackbar("Api Error", "error:: $e");
    }
  }


  Future<bool> isLoggedIn() async {
    final token = getToken();
    if (token != null) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
      }
      String url = '${AppConstants.appBaseUrl}/profile';
      try {
        final Response response = await apiClient.getSecure(url: url);
        final box = GetStorage();
        // console.log()
        // UserModel data = UserModel.fromJson(response.data);
        await box.write('user', response.data);

      // AppHelper.loggerNoStack.v(response.data);
        // AppHelper()
        return true;
      } catch (e) { 
        AppHelper.loggerNoStack.v(e);
        return false;
      }
    }else{
      return false;
    }
  }

  
}