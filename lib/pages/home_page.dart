
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

import '../core/core_export.dart';
import '../models/menu_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthController authC = Get.put(AuthController());

  @override
  void initState() {
    AppHelper.loggerNoStack.v(authC.getUser().toJson());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final List<MenuModel> menuList = [
      MenuModel(
        icon: AppImages.projectLineIcon,
        title: 'Project',
        route: '/project'
      ),
      MenuModel(
        icon: AppImages.activityLineIcon,
        title: 'Aktivitas',
        route: '/activity'
      ),
      MenuModel(
        icon: AppImages.settingsIcon,
        title: 'Pengaturan',
        route: '/settings'
      ),
    ];

    
    return Scaffold(
      body: Container(
          color: AppStyles.colorPrimary,
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Container(
                height: Get.height * 0.25,
                width: Get.width,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.logoHead,
                            width: 200,
                          ),
                          const SizedBox(height: 15),
                          const Text("Selamat Datang",
                            style: TextStyle(
                              fontSize: 35,
                              color: AppStyles.colorWhite,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(authC.getUser().name ?? "Nama Sales",
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppStyles.colorWhite,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: 
              Container(
                decoration: const BoxDecoration(
                  color: AppStyles.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )
                ),
                padding: const EdgeInsets.only(bottom: 20),
                height: Get.height * 0.75,
                width: Get.width,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 20
                    // crossAxisSpacing: AppStyles.paddingSizeXS, mainAxisSpacing: AppStyles.paddingSizeXS,
                  ),
                  itemCount: menuList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async{
                        if(menuList[index].title == 'Keluar'){
                          authC.logout();
                        }else{
                          Get.toNamed(menuList[index].route!);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        // padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              menuList[index].icon!,
                              height: 70,
                              width: 70,
                              fit: BoxFit.fill,
                              color: (menuList[index].title == 'Keluar') ? AppStyles.colorDanger : AppStyles.colorPrimary,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              menuList[index].title!,
                              style: TextStyle(
                                fontSize: 20,
                                color: (menuList[index].title == 'Keluar') ? AppStyles.colorDanger : AppStyles.colorPrimary,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              )
            ],
          ),
        )
    );
  }
}