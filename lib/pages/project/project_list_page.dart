
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../widgets/empty_page.dart';
import '../../controllers/project_controller.dart';
import '../../core/core_export.dart';

import '../../widgets/dukungan_filter.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({Key? key}) : super(key: key);

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final ProjectController c = Get.put(ProjectController());
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ProjectController>(
      initState: (state){
        
      },
      builder: (c){
        return Scaffold(
          backgroundColor: AppStyles.colorPrimary,
          appBar: CustomAppBar(
            title: "List Project",
            actionWidget : [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 10),
                child: SizedBox(
                  width: 40,
                  child : ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(
                        ProjectFilter(
                          onReset: (){
                            c.resetFilter();
                            c.pagingController.refresh();
                            Get.back();
                          },
                          onPressed: (){
                            c.pagingController.refresh();
                            Get.back();
                          }
                        ),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppStyles.colorWhite,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: SvgPicture.asset(
                      AppImages.filterIcon,
                      height: 20,
                      width: 20,
                      fit: BoxFit.fill,
                      color: AppStyles.colorPrimary,
                    ),
                  ),
                ),
              ),
            ]
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppStyles.colorPrimary,
            onPressed: () async {
              var form = await Get.toNamed("/project/create");
              if(form == true){
                Get.find<ProjectController>().pagingController.refresh();
              }
            },
            child: const Icon (Icons.add),
          ),
          body: Container(
            height: Get.height,
            decoration: const BoxDecoration(
              color: AppStyles.colorWhite, 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              child : RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => Get.find<ProjectController>().pagingController.refresh(),
                ),
                child: PagedListView<int, ProjectModel>(
                  shrinkWrap: true,
                  pagingController: Get.find<ProjectController>().pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ProjectModel>(
                    animateTransitions: true,
                    firstPageProgressIndicatorBuilder: (context){
                      return const DukunganListLoading(count : 16,);
                    },
                    noItemsFoundIndicatorBuilder : (context){
                      return const EmptyPage();
                    },
                    itemBuilder: (context, item, index){
                      return ProjectListItem(
                        item: item, 
                        onTap: (){
                          Get.toNamed("/project/show?id=${item.id}");
                        },
                      );
                    }
                  ),
                ),
              ),
            ),
          )
        );
      }
    );

  }
}