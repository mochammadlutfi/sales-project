
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../controllers/contact_controller.dart';
import '../../models/contact_model.dart';
import '../../widgets/empty_page.dart';
import '../../core/core_export.dart';

import '../../widgets/contact_list_item.dart';
class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final ContactController c = Get.put(ContactController());
  final GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //  Get.find<ContactController>().pagingController.dispose();
    // print('DISPOSE!!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ContactController>(
      initState: (state){
        Get.find<ContactController>().pagingController.addPageRequestListener((pageKey) {
          Get.find<ContactController>().getList(pageKey);
        });
      },
      builder: (c){
        return Scaffold(
          backgroundColor: AppStyles.colorPrimary,
          appBar: CustomAppBar(
            title: "List Kontak",
            actionWidget : [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 10),
                child: SizedBox(
                  width: 40,
                  child : ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
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
                                    onTap: (){
                                      c.resetFilter();
                                      c.pagingController.refresh();
                                      Get.back();
                                    },
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
                                      onPressed: (){
                                        c.pagingController.refresh();
                                        Get.back();
                                      }
                                    ),
                                  ),
                                ],
                              )

                            ],
                          )
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
              c.resetForm();
              Get.bottomSheet(
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadius.vertical(top: Radius.circular(20)),
                    color: AppStyles.colorWhite,
                  ),
                  child: Form(
                    key: contactFormKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Tambah Kontak",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                AppImages.closeIcon,
                                height: 20,
                                width: 20,
                                fit: BoxFit.fill,
                                color: AppStyles.colorPrimary,
                              ),
                            ),
                            
                          ],
                        ),

                        const SizedBox(height: 20),
                        Obx(() => 
                        CustomFormField(
                          headingText: "Nama Lengkap",
                          hintText: "Masukan Nama Lengkap",
                          obsecureText: false,
                          suffixIcon: const SizedBox(),
                          controller: c.nameC,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          errorText : c.errorForm['name']
                        )
                        ),

                        const SizedBox(height: 20,),

                        Obx(() => CustomFormField(
                          headingText: "No Handphone",
                          hintText: "Masukan No Handphone",
                          obsecureText: false,
                          suffixIcon: const SizedBox(),
                          controller: c.phoneC,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.phone,
                          errorText : c.errorForm['phone']
                        )),

                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child:  CustomButton(
                                buttonText: "Simpan", 
                                onPressed: (){
                                  if(contactFormKey.currentState!.validate()) {
                                    // AppHelper().showLoading(context);
                                    c.store();
                                  }
                                }
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  )
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                isDismissible : false,
              );
            },
            child: const Icon (Icons.add),
          ),
          body: Container(
            height: Get.height,
            // padding: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
            decoration: const BoxDecoration(
              color: AppStyles.colorWhite, 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child : RefreshIndicator(
              onRefresh: () => Future.sync(
                () => Get.find<ContactController>().pagingController.refresh(),
              ),
              child: PagedListView<int, ContactModel>(
                shrinkWrap: true,
                padding : const EdgeInsets.only(top: 10),
                pagingController: Get.find<ContactController>().pagingController,
                builderDelegate: PagedChildBuilderDelegate<ContactModel>(
                  animateTransitions: true,
                  firstPageProgressIndicatorBuilder: (context){
                    return const DukunganListLoading(count : 16,);
                  },
                  noItemsFoundIndicatorBuilder : (context){
                    return const EmptyPage();
                  },
                  itemBuilder: (context, item, index){
                    return ContactListItem(
                      item: item,
                      onRemove: (context){
                        Get.dialog(
                          WarningDialog(
                            icon: AppImages.alertIcon,
                            onConfirm: (){
                              c.delete(item.id!);
                            },
                            onCancel: (){
                              Get.back();
                            },
                          ),
                          barrierDismissible : false,
                        );
                      },
                      onEdit: (context){
                        c.resetForm();
                        c.nameC.text = item.name!;
                        c.phoneC.text = item.phone!;
                        Get.bottomSheet(
                          Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(14),
                            decoration: const BoxDecoration(
                              borderRadius:  BorderRadius.vertical(top: Radius.circular(20)),
                              color: AppStyles.colorWhite,
                            ),
                            child: Form(
                              key: contactFormKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Ubah Kontak",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: (){
                                          Get.back();
                                        },
                                        child: SvgPicture.asset(
                                          AppImages.closeIcon,
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.fill,
                                          color: AppStyles.colorPrimary,
                                        ),
                                      ),
                                      
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                  Obx(() => 
                                  CustomFormField(
                                    headingText: "Nama Lengkap",
                                    hintText: "Masukan Nama Lengkap",
                                    obsecureText: false,
                                    suffixIcon: const SizedBox(),
                                    controller: c.nameC,
                                    maxLines: 1,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.text,
                                    errorText : c.errorForm['name']
                                  )
                                  ),

                                  const SizedBox(height: 20,),

                                  Obx(() => CustomFormField(
                                    headingText: "No Handphone",
                                    hintText: "Masukan No Handphone",
                                    obsecureText: false,
                                    suffixIcon: const SizedBox(),
                                    controller: c.phoneC,
                                    maxLines: 1,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.phone,
                                    errorText : c.errorForm['phone']
                                  )),

                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:  CustomButton(
                                          buttonText: "Simpan", 
                                          onPressed: (){
                                            if(contactFormKey.currentState!.validate()) {
                                              // AppHelper().showLoading(context);
                                              c.updateContact(item.id!);
                                            }
                                          }
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            )
                          ),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          isDismissible : false,
                        );
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