import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/project_controller.dart';

import '../../core/core_export.dart';
import 'project_activity_page.dart';
import 'project_info_page.dart';
class ProjectShowPage extends StatefulWidget {
  final String id;
  const ProjectShowPage({super.key, required this.id});

  @override
  State<ProjectShowPage> createState() => _ProjectShowPageState();
}

class _ProjectShowPageState extends State<ProjectShowPage> {
  final ProjectController c = Get.put(ProjectController());

  
  @override
  void initState() {
    Get.find<ProjectController>().getDetail(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.colorPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyles.colorPrimary,
        title: const Text("Project",
          style: TextStyle(
            color: AppStyles.colorWhite
          ),
        ),
        actions : [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10),
            child: SizedBox(
              width: 40,
              child : ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppStyles.colorWhite,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                child: SvgPicture.asset(
                  AppImages.editIcon,
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  color: AppStyles.colorPrimary,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppStyles.colorGrayShade
          ),
          labelColor: AppStyles.colorPrimary,
          unselectedLabelColor: AppStyles.colorWhite,
          controller: Get.find<ProjectController>().tabC,
          tabs: Get.find<ProjectController>().myTabs
        ),
      ),
      body: SafeArea(
        child: Container(
                height: Get.height,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
                decoration: const BoxDecoration(
                  color: AppStyles.colorWhite, 
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                  child: GetBuilder<ProjectController>(
                    builder: (c){
                      return TabBarView(
                        controller: Get.find<ProjectController>().tabC,
                        children: [
                          ProjectInfoPage(data: c.data),
                          ProjectActivityPage(id: int.parse(widget.id)),
                        ],
                      );
                    }
                  ),
                ),
            )
      ),
    );
  }
}