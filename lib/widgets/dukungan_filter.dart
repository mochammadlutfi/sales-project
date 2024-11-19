import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/project_controller.dart';

import '../core/core_export.dart';
class ProjectFilter extends GetView<ProjectController> {
  final dynamic Function()? onPressed;
  final dynamic Function()? onReset;
  const ProjectFilter({
    super.key,
    this.onPressed,
    this.onReset
  });

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProjectController());
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        borderRadius:  BorderRadius.vertical(top: Radius.circular(20)),
        color: AppStyles.colorWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                   Get.back();
                },
                child: SvgPicture.asset(
                  AppImages.backIcon,
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  color: AppStyles.colorPrimary,
                ),
              ),
              
              const Text("Filter",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),

              InkWell(
                onTap: onReset,
                child: const Text("Reset",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 20),
          CustomFormField(
            headingText: "Kata kunci",
            hintText: "Masukan kata kunci",
            obsecureText: false,
            suffixIcon: const SizedBox(),
            controller: c.searchC,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.text,
          ),

          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child:  CustomButton(
                  buttonText: "Filter", 
                  onPressed: onPressed
                ),
              ),
            ],
          )

        ],
      )
    );
  }
}