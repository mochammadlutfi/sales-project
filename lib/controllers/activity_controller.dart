
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/core_export.dart';
import 'package:dio/dio.dart';

import '../models/project_activity_model.dart';

class ActivityController extends GetxController {
  
  ActivityController();

  ProjectActivityModel? _dataModel;
  ProjectActivityModel? get data => _dataModel;

  PagingController<int, ProjectActivityModel> pagingController = PagingController(firstPageKey: 1);
  final _pageSize = 20;

  TextEditingController searchC = TextEditingController();
  RxMap<String, dynamic> errorForm = RxMap<String, dynamic>({});

  @override
  void onInit() async {
    // pagingController.addPageRequestListener((pageKey) => getList(pageKey));

    super.onInit();
  }

  @override
  void onReady() {
    // pagingController.notifyPageRequestListeners(1);
    super.onReady();
  }

  @override
  void onClose() {
    pagingController.dispose();

    super.onClose();
  }

  void resetFilter(){
    searchC.text = "";
  }

  
  void resetForm(){
    errorForm.clear();
    update();
  }

  Future<void> getList(int pageKey, {int? projectId}) async {
    String url = '${AppConstants.appBaseUrl}/activity';
    try {
      final Response response = await apiClient.getSecure(url: url, queryParameters : {
        'page' : pageKey,
        'limit' : _pageSize,
        'search' : searchC.text,
        'project_id' : projectId
      });
      final List data = response.data["data"];
      final List<ProjectActivityModel> newItems = ProjectActivityModel.fromJsonList(data);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
  
  
  Future<void> detail(String id) async {
    _dataModel = null;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/caleg/saksi/$id';
    try {
        final Response response = await apiClient.getSecure(url: url);
        _dataModel = ProjectActivityModel.fromJson(response.data);

    } catch (e) {
        _dataModel = ProjectActivityModel();
    }
    update();
  }

  Future store(Map<String, dynamic> data) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/activity/store';
    var formData = FormData.fromMap(data);
    try {
      final Response response = await apiClient.postSecure(url: url, data : formData);
      AppHelper.loggerNoStack.v(response.data);
      if(response.data['success'] == true){
        Get.back(result: true);
      }else{
        errorForm.clear();
        response.data['result'].forEach((key, value) {
          errorForm[key] = value[0];
        });
        update();
      }
      // AppHelper.loggerNoStack.v(e);
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
    AppHelper().hideLoading();
  }
  
  Future updateData(int id, Map<String, dynamic> data) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/activity/$id/update';
    var formData = FormData.fromMap(data);
    try {
      final Response response = await apiClient.postSecure(url: url, data : formData);
      AppHelper.loggerNoStack.v(response.data);
      if(response.data['result'] == true){
        Get.back(result: true);
      }else{
        errorForm.clear();
        response.data['errors'].forEach((key, value) {
          errorForm[key] = value[0];
        });
        update();
      }
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
    AppHelper().hideLoading();
  }



  Future<void> delete(int id) async {
    _dataModel = null;
    String url = '${AppConstants.appBaseUrl}/caleg/saksi/$id/destroy';
    try {
        final Response response = await apiClient.delete(url: url);
        if(response.data['result'] == true){
          Get.back();
          Get.back();
          pagingController.refresh();
        }
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
    update();
  }
}