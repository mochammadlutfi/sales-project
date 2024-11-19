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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 150,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  GetBuilder<ProjectController>(
                  builder: (c){
                    return Container(
                      height: 80,
                      margin: const EdgeInsets.only(bottom : 10, left: 16, right: 16),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(c.data?.name ?? "Nama Project",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: AppStyles.colorWhite,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                  SizedBox(
                    height: 40,
                    child: TabBar(
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
                  )
                ],
              )
            ),

            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(top: 140),
              child:  Container(
                  height: Get.height - 90,
                  margin: const EdgeInsets.only(top: 15),
                  // padding: const EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                    color: AppStyles.colorWhite, 
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                  ),
                  child: GetBuilder<ProjectController>(
                    builder: (c){
                      return TabBarView(
                        controller: Get.find<ProjectController>().tabC,
                        children: [
                          // ProjectInfoPage(data: c.data),
                          // ProjectActivityPage(projectId: c.data?.id),
                          // ProjectActivityPage(data: c.data),
                      ],
                    );
                  }),
              )
            ),
          ]
        ),
      ),
    );
  }
}