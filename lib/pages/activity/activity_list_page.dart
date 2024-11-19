
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../controllers/activity_controller.dart';
import '../../models/project_activity_model.dart';
import '../../widgets/activity_list_item.dart';
import '../../widgets/empty_page.dart';
import '../../core/core_export.dart';

import '../../widgets/dukungan_filter.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({Key? key}) : super(key: key);

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  final ActivityController c = Get.put(ActivityController());
  
  @override
  void initState() {
    Get.find<ActivityController>().pagingController.addPageRequestListener((pageKey) {
      Get.find<ActivityController>().getList(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ActivityController>(
      initState: (state){
        
      },
      builder: (c){
        return Scaffold(
          backgroundColor: AppStyles.colorPrimary,
          appBar: CustomAppBar(
            title: "List Aktivitass",
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
                  () => Get.find<ActivityController>().pagingController.refresh(),
                ),
                child: PagedListView<int, ProjectActivityModel>(
                  shrinkWrap: true,
                  pagingController: Get.find<ActivityController>().pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ProjectActivityModel>(
                    animateTransitions: true,
                    firstPageProgressIndicatorBuilder: (context){
                      return const DukunganListLoading(count : 16,);
                    },
                    noItemsFoundIndicatorBuilder : (context){
                      return const EmptyPage();
                    },
                    itemBuilder: (context, item, index){
                      return ActivityListItem(
                        item: item, 
                        onTap: (){
                          
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