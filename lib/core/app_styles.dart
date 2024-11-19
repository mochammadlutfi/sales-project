
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyles{

  // Color Constants
  static const Color colorPrimary = Color(0xff3073F1);
  static const Color colorDanger = Color(0xffdc2626);
  static const Color colorWarning = Color(0xffffbe10);

  static const Color colorPink = Color(0xFFcd367a);
  static const Color colorPrimaryLight = Color(0xFF88c4e3);
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorWhiteShade = Color(0xFFF8F9FA);
  static const Color colorBlack = Color(0xff000000);
  static const Color colorGray = Color(0xff7a7a7a);
  static const Color colorGrayShade = Color(0xFFEBEBEB);
  
  static const Color colorText = Color(0xFF3e444a);
  static const Color colorBorderLight = Color(0xFFe4e7ed);

  // Text Color
  static const Color colorHintText = Color(0xFFC7C7CD);

  
  static const Color bgColor = Color(0xFFf0f2f5);

  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 10;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 14 : 13;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 16 : 14;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 18 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 20 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 26 : 24;
  static double fontSizeForReview = Get.context!.width >= 1300 ? 36 : 36;

  static const double paddingSizeMINI = 2.0;
  static const double paddingSizeTINE = 3.0;
  static const double paddingSizeXS = 5.0;
  static const double paddingSizeEIGHT = 8.0;
  static const double paddingSizeSMALL = 10.0;
  static const double paddingSizeDEFAULT = 15.0;
  static const double paddingSizeLARGE = 20.0;
  static const double paddingSizeXL = 25.0;
  static const double paddingSizeXXL = 40.0;


  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 50.0;

  
  static const headerTextStyle = TextStyle(
      color: colorText, 
      fontSize: 18, 
      fontWeight: FontWeight.w700
  );

  static const textFieldHeading =
      TextStyle(color: colorText, fontSize: 14, fontWeight: FontWeight.w500);

  static const textFieldHintStyle = TextStyle(
      color: colorHintText, fontSize: 14, fontWeight: FontWeight.normal);

      
  static const textProfileName = TextStyle(
    color: colorText, 
    fontSize: 18, 
    fontWeight: FontWeight.w600
  );

  static const heading1 = TextStyle(
    color: colorText, 
    fontSize: 17, 
    fontWeight: FontWeight.bold
  );

  

    static const textTableHead = TextStyle(
        color: AppStyles.colorWhite, 
        fontSize: 14, 
        fontWeight: FontWeight.bold
      );
    static const textTableBody = TextStyle(
        color: AppStyles.colorText, 
        fontSize: 14, 
        fontWeight: FontWeight.bold
      );
    


  static const authButtonTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: colorWhiteShade);

  
  ThemeData lightTheme = ThemeData(
    
    // brightness: Brightness.light,
    scaffoldBackgroundColor: bgColor,
    buttonTheme: const ButtonThemeData(buttonColor: colorPrimary),
    colorScheme: ColorScheme.fromSeed(
          seedColor: colorPrimary,
          brightness: Brightness.light,
          primary: colorPrimary,
    ),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        titleTextStyle : TextStyle(
          color: colorWhite,
          fontSize: 18,
          fontWeight: FontWeight.w700
        ),
        centerTitle: true,
        backgroundColor: colorPrimary,
        iconTheme: IconThemeData(color: colorWhite),
        actionsIconTheme: IconThemeData(color: colorText,
      )
    ),

    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: colorText, fontSize: 30), //👈 we will be able to access these in our widgets later
        headlineMedium: TextStyle(color: colorText, fontSize: 25)
    )
  );
}