import 'core_export.dart';

class AppImages {

  static String get logo => 'logo'.png;
  static String get logoVer => 'logo_big'.png;
  static String get update => 'update'.png;
  static String get logoHead => 'logo_ver_white'.png;
  // static String get splashBg => 'splash_bg'.png;
  static const String splashBg = 'assets/images/splash_bg.png';
  static const String ktp = 'assets/images/ktp.png';
  static const String avatar = '${AppConstants.baseUrl}/media/placeholder/avatar.jpg';

  static const String contactLineIcon = 'assets/icons/contact.svg';
  static const String logoutLineIcon = 'assets/icons/logout.svg';
  static const String homeLineIcon = 'assets/icons/home.svg';
  static const String profileLineIcon = 'assets/icons/profile.svg';
  static const String menuLineIcon = 'assets/icons/menu.svg';
  static const String cardLineIcon = 'assets/icons/card.svg';
  static const String cartLineIcon = 'assets/icons/cart.svg';
  static const String peopleLineIcon = 'assets/icons/people.svg';
  static const String projectLineIcon = 'assets/icons/project.svg';
  static const String activityLineIcon = 'assets/icons/activity.svg';
  
  static const String privacyIcon = 'assets/icons/privacy.svg';
  static const String errorIcon = 'assets/icons/error.svg';
  static const String emptyIcon = 'assets/icons/empty.svg';
  static const String badgeIcon = 'assets/icons/badge.svg';
  static const String backIcon = 'assets/icons/back.svg';
  static const String manIcon = 'assets/icons/man.svg';
  static const String womanIcon = 'assets/icons/woman.svg';
  static const String statsIcon = 'assets/icons/stats.svg';
  static const String countIcon = 'assets/icons/count.svg';
  
  static const String userEditIcon = 'assets/icons/user_edit.svg';
  static const String trashIcon = 'assets/icons/trash.svg';
  static const String editIcon = 'assets/icons/edit.svg';

  static const String passwordIcon = 'assets/icons/password.svg';
  static const String alertIcon = 'assets/icons/question.svg';
  static const String infoIcon = 'assets/icons/info.svg';
  static const String filterIcon = 'assets/icons/filter.svg';
  static const String settingsIcon = 'assets/icons/settings.svg';
  static const String closeIcon = 'assets/icons/close.svg';

  static String getImage(image){
    return AppConstants.baseUrl + image;
  }
  
}

extension on String {
  String get png => 'assets/images/$this.png';
}