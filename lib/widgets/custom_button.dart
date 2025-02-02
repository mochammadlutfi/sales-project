
import '../core/core_export.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? buttonText;
  final bool? transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final IconData? icon;
  final String? assetIcon;
  
  const CustomButton({
    Key? key, 
    this.onPressed, 
    required this.buttonText, 
    this.transparent = false, 
    this.margin, 
    this.width, 
    this.height,
    this.fontSize, 
    this.radius = 5, 
    this.icon, 
    this.assetIcon
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed != null ? AppStyles.colorPrimary : transparent!
          ? Colors.transparent : Theme.of(context).disabledColor,
      minimumSize: Size(width != null ? width! : 1260, height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
    );

    return Center(
        child: SizedBox(
            width: width ?? 1260,
            child: Padding(
              padding: margin == null ? const EdgeInsets.all(0) : margin!,
              child: TextButton(
                onPressed: onPressed,
                style: flatButtonStyle,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon != null ? Padding(
                        padding: const EdgeInsets.only(right: AppStyles.paddingSizeXS, left: AppStyles.paddingSizeXS,),
                        child: Icon(icon, color: transparent! ? Theme.of(context).primaryColor : Colors.white,size: 18,),)
                          : assetIcon!=null?Padding(padding: const EdgeInsets.symmetric(horizontal: AppStyles.paddingSizeSMALL),
                            child: Image.asset(assetIcon!,height: 16,width: 16,),
                          )
                          :const SizedBox(),
                      Text(
                          buttonText ??'',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: transparent! ? Theme.of(context).primaryColor : Colors.white,
                            fontSize: fontSize ?? AppStyles.fontSizeDefault,
          )),
        ]),
      ),
    )));
  }
}