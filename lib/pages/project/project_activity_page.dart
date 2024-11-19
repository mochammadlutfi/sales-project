
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pds/models/project_activity_model.dart';

import '../../controllers/activity_controller.dart';
import '../../core/core_export.dart';
import '../../widgets/activity_list_item.dart';
import '../../widgets/empty_page.dart';


class ProjectActivityPage extends StatefulWidget {
  final int id;
  const ProjectActivityPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProjectActivityPage> createState() => _ProjectActivityPageState();
}

class _ProjectActivityPageState extends State<ProjectActivityPage> {
  final ActivityController c = Get.put(ActivityController());
  
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
    Get.put(ActivityController());
    return GetBuilder<ActivityController>(
      initState: (state){
        Get.find<ActivityController>().pagingController.addPageRequestListener((pageKey) {
          Get.find<ActivityController>().getList(pageKey, projectId : widget.id);
        });
      },
      builder: (c){
      return Scaffold(
        backgroundColor: AppStyles.colorWhite,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyles.colorPrimary,
          onPressed: () async {
            var form = await Get.toNamed("/activity/create?project=${widget.id}");
            if(form == true){
              Get.find<ActivityController>().pagingController.refresh();
            }
          },
          child: const Icon (Icons.add),
        ),
        body : Container(
            height: Get.height - 140,
            padding: const EdgeInsets.only(top:10),
            decoration: const BoxDecoration(
              color: AppStyles.colorWhite, 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              child: RefreshIndicator(
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
  
  
  Widget plainText({
    required String label,
    required String value,
    context
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}