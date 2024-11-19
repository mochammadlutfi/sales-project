import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'core_export.dart';

class AppHelper {
  
  static var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );


  static String getHtml(url){
    return AppConstants.baseUrl + url;
  }
  
  showLoading(context){
    return Loader.show(context,
      overlayColor: Colors.black26,
      progressIndicator: Container(
        width: 160,
        height: 160,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppStyles.colorWhite,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 20,),
              Text("Mohon Tunggu..",
                style: TextStyle(
                  fontSize: 14
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  hideLoading(){
    return Loader.hide();
  }

  static String counter(int? number){
    String formattedNumber = "-";

    if(number != null){
      formattedNumber = NumberFormat('#,##0').format(number);
    }

    return formattedNumber;
  }

  
  static String percentage(int number, int total){
    var percent = 100 * number / total;
    String formattedNumber = percent.isNaN ? "0%" : '${percent.round().toString()}%';

    return formattedNumber;
  }

  static showSnackbar(String type, String msg, SnackPosition position){

    String head = (type == 'success') ? 'Berhasil!' : 'Oops!';

    Get.snackbar(head,
      msg,
      padding: const EdgeInsets.only(left:10, right: 10, top: 10, bottom: 10),
      icon: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 30,
        width: 30,
        child: SvgPicture.asset(
          AppImages.errorIcon,
          height: 15,
          width: 15,
          fit: BoxFit.fill,
          color: AppStyles.colorWhite,
        ),
      ),
      duration : const Duration(seconds: 5),
      snackPosition: position,
      margin: const EdgeInsets.only(bottom: 20, left: 14, right: 14),
      backgroundColor: AppStyles.colorDanger,
      colorText: AppStyles.colorWhite
    );
  }

  static int getLevelCaleg(String level){
    int l = 0;
    if(level == 'DPR RI'){
      l = 1;
    }else if(level == 'DPRD Provinsi'){
      l = 2;
    }else if(level == 'DPRD Kota/Kabupaten'){
      l = 3;
    }else if(level == 'DPD'){
      l = 4;
    }

    return l;
  }
}