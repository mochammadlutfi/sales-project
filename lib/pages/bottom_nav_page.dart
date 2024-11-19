import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

import '../../controllers/bottom_nav_controller.dart';
import '../core/core_export.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'setting_page.dart';

class BottomNavPage extends StatefulWidget {
  final int pageIndex;
  const BottomNavPage({super.key, required this.pageIndex});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  final int _pageIndex = 0;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final BottomNavController controller = Get.put(BottomNavController());
  final AuthController authC = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          Get.find<BottomNavController>().changePage(BnbItem.home);
          return false;
        } else {
          Fluttertoast.showToast(
              msg: 'Tekan Sekali Lagi Untuk Keluar',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton:
         InkWell(
          onTap: (){
            Get.bottomSheet(
              const MenuPage(),
              backgroundColor: Colors.transparent,
              isScrollControlled: true
            );
          },
          child: Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _pageIndex == 2
                  ? null
                  : Get.isDarkMode
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppStyles.colorPrimary.withOpacity(0.4),
                width: 4,
              )
            ),
            child: SvgPicture.asset(
                AppImages.menuLineIcon,
                color: Get.isDarkMode ? Theme.of(context).primaryColorLight: Colors.white,
                height: 40,
                width: 40,
                fit: BoxFit.none,
              )
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: Obx(() => SafeArea(
          child: Material(
              elevation: 20,
              child : Container(
                height: 65,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                color: AppStyles.colorWhite,
                child: Row(
                  children: [
                    _bnbItem(
                        icon: AppImages.homeLineIcon,
                        bnbItem: BnbItem.home,
                        text : 'Beranda',
                        onTap: () {
                          Get.find<BottomNavController>().changePage(BnbItem.home);
                        },
                        context: context),

                    _bnbItem(
                        icon: '',
                        bnbItem: BnbItem.menu,
                        text : 'Menu',
                        onTap: () {
                          Get.bottomSheet(
                            const MenuPage(),
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true
                          );
                        },
                        context: context),

                  _bnbItem(
                      icon: AppImages.profileLineIcon,
                      bnbItem: BnbItem.setting,
                      text : 'Profil',
                      onTap: () {
                          Get.find<BottomNavController>().changePage(BnbItem.setting);
                      },
                      context: context),
                ]
              ),
            ),
          ),
        )),
        body: Obx(() => _bottomNavigationView()),
      ),
    );
  }

  Widget _bnbItem({
    required String icon,
    required BnbItem bnbItem,
    required GestureTapCallback onTap,
    required String text,
    context}) {
    return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            icon.isEmpty ? const SizedBox(width: 20, height: 20) :
            SvgPicture.asset(
              icon,
              color: Get.find<BottomNavController>().currentPage.value == bnbItem ? AppStyles.colorPrimary : AppStyles.colorGray,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 5.0),
            text.isEmpty ? const SizedBox(width: 15, height: 13) : 
            Text(text,
                style: TextStyle(
                  fontSize: AppStyles.fontSizeSmall,
                  color: Get.find<BottomNavController>().currentPage.value == bnbItem
                      ? AppStyles.colorPrimary
                      : AppStyles.colorGray,
                )),
          ]),
        ));
  }

  _bottomNavigationView() {
    switch (Get.find<BottomNavController>().currentPage.value) {
      case BnbItem.home:
        return const HomePage();
      case BnbItem.setting:
        return const SettingPage();
      case BnbItem.rekrutan:
        return const SettingPage();

      case BnbItem.menu:
        break;
    }
  }
}

