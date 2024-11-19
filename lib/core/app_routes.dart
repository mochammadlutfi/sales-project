// Core
import 'package:get/get.dart';
import 'package:pds/pages/activity/activity_create_page.dart';
import 'package:pds/pages/activity/activity_list_page.dart';
import '../pages/project/project_create_page.dart';
import '../pages/project/project_edit_page.dart';
import '../pages/project/project_list_page.dart';
import '../pages/project/project_show_page.dart';

import '../pages/setting_page.dart';
import '../pages/splash_page.dart';
import '../pages/base/web_page.dart';
import '../pages/home_page.dart';

// Auth
import '../pages/auth/login_page.dart';

// Contact Menu

// Dukungan Menu

// Setting Menu
import '../pages/settings/user_profile_page.dart';
import '../pages/settings/change_password_page.dart';
import '../pages/base/update_page.dart';

// Screen List

class AppRoutes {
  static const String initial = '/';

  static String getInitialRoute() => initial;
  static String getSplashRoute() {
    String data = 'null';
    return '/splash?data=$data';
  }

  static List<GetPage> routes = [
      GetPage(
        name: initial,
        page: () => const HomePage()
      ),
      
      GetPage(
        name: "/splash", 
        page: () => const SplashPage()
      ),

      GetPage(
        name: "/login", 
        page: () => LoginPage(
          exitFromApp: Get.parameters['page'] == '/splash',
        )
      ),

      GetPage(
        name: "/project",
        page: () => const ProjectListPage()
      ),
      
      GetPage(
        name: "/project/create", 
        page: () => const ProjectCreatePage()
      ),

      GetPage(
        name: "/project/edit", 
        page: () => ProjectEditPage(data: Get.arguments)
      ),

      GetPage(
        name: "/project/show", 
        page: () => ProjectShowPage(id : Get.parameters['id']!)
      ),

      GetPage(
        name: "/activity",
        page: () => const ActivityListPage()
      ),
      
      GetPage(
        name: "/activity/create", 
        page: () => const ActivityCreatePage()
      ),

      GetPage(
        name: "/activity/edit", 
        page: () => ProjectEditPage(data: Get.arguments)
      ),

      GetPage(
        name: "/settings", 
        page: () => const SettingPage()
      ),
      
      GetPage(
        name: "/user", 
        page: () => const UserProfilePage()
      ),

      
      GetPage(
        name: "/user/password", 
        page: () => const ChangePasswordPage()
      ),


      GetPage(
        name: "/html", 
        page: () => WebPage(url: Get.arguments)
      ),

      GetPage(
        name: "/update", 
        page: () => const UpdatePage()
      ),
    ];
}
