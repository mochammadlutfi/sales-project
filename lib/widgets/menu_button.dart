import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/core_export.dart';
import '../models/menu_model.dart';

class MenuButton extends StatelessWidget {
  final MenuModel? menu;
  final bool? isLogout;
  const MenuButton({Key? key, required this.menu, this.isLogout}): super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 3;
    double size = ((context.width)/count) - AppStyles.paddingSizeDEFAULT;

    return Stack(
      children: [
        Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppStyles.paddingSizeXS)),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            height: size-(size*0.3),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: AppStyles.paddingSizeSMALL),
            alignment: Alignment.center,
            child: 
            SvgPicture.asset(
              menu!.icon!,
              height: 40,
              width: 40,
              fit: BoxFit.none,
              color: AppStyles.colorPrimary,
            )
          ),
          const SizedBox(height: AppStyles.paddingSizeEIGHT),
          Text(menu!.title!, style: TextStyle(fontSize: AppStyles.fontSizeSmall), textAlign: TextAlign.center),
        ]),
        Positioned.fill(
          child: RippleButton(
            onTap: () async {
              Get.offNamed(menu!.route!);
            }
          )
        )
      ],
    );
  }
}

