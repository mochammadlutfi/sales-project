import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;


class SplashController extends GetxController {

  bool _firstTimeConnectionCheck = true;
  final bool _hasConnection = true;
  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;
  RxString appVersion = ''.obs;
  
  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  Future<bool> getBase() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    bool isSuccess = false;
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    // String url = '${AppConstants.appBaseUrl}/base';
    // try {
    //   final Response response = await apiClient.getSecure(url: url);
    //   final data = response.data;
    //   appVersion.value = data['app_version'];
    //   isSuccess = true;
      
    // } catch (e) {
    //   AppHelper.loggerNoStack.e(e);
    //   isSuccess = false;
    // }
    
      isSuccess = true;
    update();
    return isSuccess;
  }

  
  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
  }

}
