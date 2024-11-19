import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'bindings/initial_binding.dart';
import 'core/app_routes.dart';
import 'core/core_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      Intl.defaultLocale = 'id';
      initializeDateFormatting("id_ID");
      return GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: { PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        theme: AppStyles().lightTheme,
        initialBinding: InitialBinding(),
        initialRoute: AppRoutes.getSplashRoute(),
        getPages: AppRoutes.routes,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 500),
        builder: (context, widget) => Material(
          child: Stack(children: [
            widget!,
          ],),
        ),
      );
    
  }
}
