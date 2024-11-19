
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../controllers/auth_controller.dart';
import '../core/core_export.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  final SplashController c = Get.put(SplashController());
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {

    AppHelper.loggerNoStack.v(Get.find<SplashController>().appVersion);

    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // if(!firstTime) {
        bool isNotConnected = result == ConnectivityResult.none;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        
        Get.snackbar(isNotConnected ? "Oops!" : "Yeay!",
          isNotConnected ? 'Tidak Terhubung Internet' : 'Terhubung Internet',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 20, left: 14, right: 14),
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          colorText: AppStyles.colorWhite
        );
        _navigate();
    });
    super.initState();
  }

  void _navigate(){
    Get.find<SplashController>().getBase().then((isSuccess){
      if(isSuccess){
        Timer(const Duration(seconds: 2), () async {
          AppHelper.loggerNoStack.v(Get.find<SplashController>().appVersion.value);
          bool isAvailableUpdate = false;

          if(GetPlatform.isAndroid && Get.find<SplashController>().appVersion.value != "") {
            int currentVersion = Get.find<SplashController>().getExtendedVersionNumber(AppConstants.appVersion);
            int lastVersion = Get.find<SplashController>().getExtendedVersionNumber(Get.find<SplashController>().appVersion.value);

            if(currentVersion == lastVersion){
              isAvailableUpdate = false;
            }else if(currentVersion >= lastVersion){
              isAvailableUpdate = false;
            }else if(currentVersion < lastVersion){
              isAvailableUpdate = true;
            }
          }

          if(isAvailableUpdate){
            Get.toNamed('/update');
          }else{
            if (await Get.find<AuthController>().isLoggedIn()) {
              Get.offNamed('/');
            }else{
              Get.offNamed('/login');
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.colorWhite,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AppImages.splashBg).image,
            fit: BoxFit.fitWidth
          )
        ),
        alignment: Alignment.center,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Image.asset(
                AppImages.logoVer,
                width: 200,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  CircularProgressIndicator(
                    color: AppStyles.colorPrimary,
                  ),
                  SizedBox(height: 30,),

                  Text("App Version 1.0.0",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}