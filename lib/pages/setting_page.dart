
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/core_export.dart';
import '../controllers/auth_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.colorPrimary,
          appBar: const CustomAppBar(
            title: "Pengaturan",
            actionWidget : [

            ]
          ),
      body: SafeArea(
        child: Container(
            height: Get.height,
            decoration: const BoxDecoration(
              color: AppStyles.colorWhite, 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
            ),
            child: ClipRRect(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
                    child: Column(
                      children: <Widget>[
                      
                        listBtn(
                          icon: AppImages.userEditIcon,
                          text: "Ubah Profil",
                          onTap: () async {
                            final result = await Get.toNamed('/user');
                            if(result == true){
                              Get.find<AuthController>().updateUser();
                            }
                          }, 
                        ),

                        const SizedBox(
                          height: 10,
                          child: Divider(thickness: 1,),
                        ),
                        listBtn(
                          icon: AppImages.passwordIcon,
                          text: "Ubah Password",
                          onTap: (){
                            Get.toNamed('/user/password');
                          }, 
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    child: TextButton(
                      onPressed: (){
                          authC.logout();
                      },
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 44)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                          ),
                          backgroundColor: MaterialStateProperty.all(AppStyles.colorDanger)
                      ),
                      child: const Text("Keluar",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ),
                  ),

                
                
                ],
              ),
            ),
        ),
      ),
    );
  }

  
  Widget listBtn({
    required String icon,
    required GestureTapCallback onTap,
    required String text,
    context}) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: AppStyles.colorWhite,
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        leading: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppStyles.bgColor,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              icon,
              height: 30,
              width: 30,
              fit: BoxFit.fill,
              color: AppStyles.colorPrimary,
            )
          ),
        title: Text(text,
          style: const TextStyle(
            color: AppStyles.colorText,
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
    ),
      
    );
  }
}