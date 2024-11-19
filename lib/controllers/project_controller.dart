
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/core_export.dart';
import 'package:dio/dio.dart';


class ProjectController extends GetxController with GetSingleTickerProviderStateMixin{
  List<ProjectModel> recentDukungan = <ProjectModel>[].obs;
  RxBool isLoading = false.obs;
  
  ProjectModel? _dataModel;
  ProjectModel? get data => _dataModel;

  
  PagingController<int, ProjectModel> pagingController = PagingController(firstPageKey: 1);
  final _pageSize = 20;

  RxMap<String, dynamic> errorForm = RxMap<String, dynamic>({});

  late TabController tabC;
  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Detail",
    ),
    const Tab(
      text: "Aktivitas",
    ),
  ];
  
  TextEditingController searchC = TextEditingController();
  Rx<KotaModel> kota = KotaModel().obs;
  Rx<KecamatanModel> kecamatan = KecamatanModel().obs;
  Rx<KelurahanModel> kelurahan = KelurahanModel().obs;
  RxBool kotaEnable = true.obs;
  RxBool kecamatanEnable = true.obs;

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) => getList(pageKey));
    tabC = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    kota.value = KotaModel();
    kecamatan.value = KecamatanModel();
    kelurahan.value = KelurahanModel();
    pagingController.dispose();
    super.onClose();
  }

  
  Future<void> getList(int pageKey) async {
    Map<String, dynamic> filter = {
        'page' : pageKey,
        'limit' : _pageSize,
        'search' : searchC.text,
    };

    String url = '${AppConstants.appBaseUrl}/project';
    try {
      final Response response = await apiClient.getSecure(url: url, queryParameters : filter);
      final List data = response.data["data"];
      final List<ProjectModel> newItems = ProjectModel.fromJsonList(data);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      AppHelper.loggerNoStack.v(error);
      pagingController.error = error;
    }
  }

  Future<void> getRecent() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/caleg/dukungan/recent';
    try {
      final Response response = await apiClient.getSecure(url: url);
      // if(response.data['success'] == true){
        final List data = response.data;
        recentDukungan = ProjectModel.fromJsonList(data);
        // AppHelper.loggerNoStack.v(recentDukungan);
      // }
    } catch (e) {
      AppHelper.loggerNoStack.v(e);
      recentDukungan = [];
    }
    update();
  }
  


  void resetFilter(){
    searchC.text = "";
    kota.value = KotaModel();
    kecamatan.value = KecamatanModel();
    kelurahan.value = KelurahanModel();
  }
  
  Future<void> getDetail(String id) async {
    _dataModel = null;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/project/$id';
    try {
        final Response response = await apiClient.getSecure(url: url);
        _dataModel = ProjectModel.fromJson(response.data);

    } catch (e) {
        _dataModel = ProjectModel();
    }
    update();
  }

  Future store(Map<String, dynamic> data) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // return AuthModel.withError(statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    String url = '${AppConstants.appBaseUrl}/project/store';
    var formData = FormData.fromMap(data);
    try {
      final Response response = await apiClient.postSecure(url: url, data : formData);
      // AppHelper.loggerNoStack.v(response.data);
      if(response.data['success'] == true){
        Get.back(result: true);
      }else{
        errorForm.clear();
        response.data['result'].forEach((key, value) {
          errorForm[key] = value[0];
        });
        update();
      AppHelper.loggerNoStack.v(errorForm);
      }
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
    String url = '${AppConstants.appBaseUrl}/project/$id/update';
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
    String url = '${AppConstants.appBaseUrl}/project/$id/destroy';
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