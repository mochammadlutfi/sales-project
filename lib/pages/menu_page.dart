import 'package:get/get.dart';
import '../core/core_export.dart';
import '../models/menu_model.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../widgets/menu_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> menuList = [
      MenuModel(
        icon: AppImages.peopleLineIcon,
        title: 'Pendukung',
        route: '/pendukung'
      ),
      MenuModel(
        icon: AppImages.peopleLineIcon,
        title: 'Relawan',
        route: '/relawan'
      ),
      MenuModel(
        icon: AppImages.statsIcon,
        title: 'Statistik',
        route: '/statistik'
      ),
    ];
    
    return PointerInterceptor(
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.paddingSizeSMALL),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).cardColor,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, 
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.keyboard_arrow_down_rounded, size: 30,color: Theme.of(context).colorScheme.primary,),
          ),
          const SizedBox(height: AppStyles.paddingSizeXS),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (1/1.2),
              crossAxisSpacing: AppStyles.paddingSizeXS, mainAxisSpacing: AppStyles.paddingSizeXS,
            ),
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              return MenuButton(menu: menuList[index]);
            },
          ),

        ]),
      ),
    );

  }
}