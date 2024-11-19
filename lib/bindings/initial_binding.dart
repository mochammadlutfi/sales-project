import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AuthController());
  }

}