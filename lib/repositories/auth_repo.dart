import '../core/core_export.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../models/user_model.dart';

class AuthRepo {

  static Future<UserModel> login(String email, String password) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/login';
    try {
      final Response response = await apiClient.post(url: url, data : {
        'username' : email,
        'password' : password
      });
      AppHelper.loggerNoStack.v(response.data);
       return UserModel.fromJson(response.data['result']);
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
      return UserModel();
    }
  }


  static Future logout() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/logout';
    try {
      final Response response = await apiClient.postSecure(url: url);
      if(response.data['success'] == true){
        return true;
      }
      
    } catch (e) {
      return false;
    }
  }

    static Future<UserModel> getCurrentUser() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/profile';
    try {
      final Response response = await apiClient.getSecure(url: url);
       return UserModel.fromJson(response.data['data']);
    } catch (e) {
      return UserModel();
    }
  }
}