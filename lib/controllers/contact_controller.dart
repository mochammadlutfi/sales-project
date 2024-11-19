

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/core_export.dart';
import '../models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactController extends GetxController {
  
  ContactController();

  ContactModel? _contactModel;
  ContactModel? get data => _contactModel;

  PagingController<int, ContactModel> pagingController = PagingController(firstPageKey: 0);
  final _pageSize = 20;

  TextEditingController searchC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  RxMap<String, dynamic> errorForm = RxMap<String, dynamic>({});

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) => getList(pageKey));

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
    nameC.text = "";
    phoneC.text = "";
    errorForm.clear();
    update();
  }

  Future<void> getList(int pageKey) async {
    String url = '${AppConstants.appBaseUrl}/caleg/contact';
    try {
      final Response response = await apiClient.getSecure(url: url, queryParameters : {
        'page' : pageKey,
        'limit' : _pageSize,
        'search' : searchC.text,
      });
      final List data = response.data["data"];
      final List<ContactModel> newItems = ContactModel.fromJsonList(data);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // pagingController.error = error;
    }
  }

  Future store() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/caleg/contact/store';
    var formData = FormData.fromMap({
      'name' : nameC.text,
      'phone' : phoneC.text,
    });
    try {
      final Response response = await apiClient.postSecure(url: url, data : formData);
      AppHelper.loggerNoStack.v(response.data);
      if(response.data['result'] == true){
        Get.back();
        pagingController.refresh();
      }else{
        errorForm.clear();
        response.data['errors'].forEach((key, value) {
          errorForm[key] = value[0];
        });
        update();
          AppHelper.loggerNoStack.v(errorForm);
      }
      // AppHelper().hideLoading();
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
  }

  Future<void> getDetail(String id) async {
    // final result = await PendukungRepo.getDetail(id);
    // _contactModel = result;
    // update();
  }

  Future updateContact(int id) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/caleg/contact/$id/update';
    var formData = FormData.fromMap({
      'name' : nameC.text,
      'phone' : phoneC.text,
    });
    try {
      final Response response = await apiClient.postSecure(url: url, data : formData);
      AppHelper.loggerNoStack.v(response.data);
      if(response.data['result'] == true){
        Get.back();
        pagingController.refresh();
      }else{
        errorForm.clear();
        response.data['errors'].forEach((key, value) {
          errorForm[key] = value[0];
        });
        update();
          AppHelper.loggerNoStack.v(errorForm);
      }
      // AppHelper().hideLoading();
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
  }

  Future<void> delete(int id) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/caleg/contact/$id/delete';
    try {
        final Response response = await apiClient.delete(url: url);
        if(response.data['result'] == true){
          Get.back();
          pagingController.refresh();
        }
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
    }
  }
}