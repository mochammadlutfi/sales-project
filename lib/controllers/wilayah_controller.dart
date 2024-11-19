import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:pds/models/sales_model.dart';
import '../../../core/core_export.dart';
import '../models/provinsi_model.dart';
import '../models/branch_model.dart';

class WilayahController extends GetxController {

  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchController.text = "";
  }


  Future<List<ProvinsiModel>> getProvinsi() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/base/daerah';
    try {
        var  response = await apiClient.get(url: url, queryParameters : {
          'type' : 'provinsi',
        });
        
       final data = response.data;
        if (data != null) {
          return ProvinsiModel.fromJsonList(data);
        }
        return [];

    } catch (e) {
      // return ProvinsiModel.withError(msg: apiClient.handleError(e));
        return [];
      // return
    }
  }

  
  Future<List<KotaModel>> getKota(String? parentId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }

    String url = '${AppConstants.appBaseUrl}/base/daerah';
    try {
        var  response = await apiClient.get(url: url, queryParameters : {
          'type' : 'kota',
          'parent_id' : parentId
        });
        
       final data = response.data;
        if (data != null) {
          return KotaModel.fromJsonList(data);
        }
        return [];

    } catch (e) {
      // return ProvinsiModel.withError(m
      //
      //sg: apiClient.handleError(e));
        return [];
      // return
    }
  }
  
  Future<List<KecamatanModel>> getKecamatan(String? parentId, String? filter) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }

    String url = '${AppConstants.appBaseUrl}/base/daerah';
    try {
        var  response = await apiClient.get(url: url, queryParameters : {
          'type' : 'kecamatan',
          'parent_id' : parentId,
          'filter' : filter,
        });
        
       final data = response.data;
        if (data != null) {
          return KecamatanModel.fromJsonList(data);
        }
        return [];

    } catch (e) {
      // return ProvinsiModel.withError(m
      //
      //sg: apiClient.handleError(e));
        return [];
      // return
    }
  }
  
  Future<List<KelurahanModel>> getKelurahan(String? parentId, String? filter) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }

    String url = '${AppConstants.appBaseUrl}/base/daerah';
    try {
        var  response = await apiClient.get(url: url, queryParameters : {
          'type' : 'kelurahan',
          'parent_id' : parentId,
          'filter' : filter
        });
        
       final data = response.data;
        if (data != null) {
          return KelurahanModel.fromJsonList(data);
        }
        return [];

    } catch (e) {
      // return ProvinsiModel.withError(m
      //
      //sg: apiClient.handleError(e));
        return [];
      // return
    }
  }
  
  
  Future<List<BranchModel>> getBranch() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }

    String url = '${AppConstants.appBaseUrl}/branch';
    try {
        var  response = await apiClient.get(url: url, queryParameters : {

        });
        
       final data = response.data;
        if (data != null) {
          return BranchModel.fromJsonList(data);
        }
        return [];

    } catch (e) {
      AppHelper.loggerNoStack.e(e);
      return [];
    }
  }

  Future<List<SalesModel>> getSales(int? branchId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }

    String url = '${AppConstants.appBaseUrl}/sales';
    try {
        var  response = await apiClient.get(url: url, queryParameters : {
          'branch_id' : branchId,
        });
        
       final data = response.data;
        if (data != null) {
          return SalesModel.fromJsonList(data);
        }
        return [];

    } catch (e) {
      AppHelper.loggerNoStack.e(e);
      return [];
    }
  }
}