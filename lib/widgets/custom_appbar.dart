import 'package:get/get.dart';
import '../core/core_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? hasBackBtn;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? centerTitle;
  final Color? bgColor;
  final List<Widget>? actionWidget;

  const CustomAppBar({
    super.key, 
    required this.title, 
    this.hasBackBtn = true, 
    this.onBackPressed,
    this.showCart = false, 
    this.centerTitle = true,
    this.bgColor, 
    this.actionWidget
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!, 
        style: const TextStyle(fontSize: 18, color: AppStyles.colorWhite),
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      backgroundColor:Get.isDarkMode ? Theme.of(context).cardColor.withOpacity(.2) : AppStyles.colorPrimary,
      shape: Border(bottom: BorderSide(
          width: .4,
          color: Theme.of(context).primaryColorLight.withOpacity(.2))),
      elevation: 0.2,
      actions: actionWidget,
    );
  }
  @override
  Size get preferredSize => const Size(1260, 60);
}