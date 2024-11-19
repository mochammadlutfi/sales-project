
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

import '../../controllers/activity_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../core/core_export.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/upload_foto_dukungan_widget.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';



class ActivityCreatePage extends StatefulWidget {
  final String? project;
  const ActivityCreatePage({Key? key, this.project}) : super(key: key);

  @override
  State<ActivityCreatePage> createState() => _ActivityCreatePageState();
}

class _ActivityCreatePageState extends State<ActivityCreatePage> {
  final ActivityController c = Get.put(ActivityController());
  final GlobalKey<FormState> activityFormKey = GlobalKey<FormState>();
  TextEditingController descriptionC = TextEditingController();
  File? avatar;
  DateTime? dateC;
  
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  ProjectModel? project;

  final FocusNode _alamatFocus = FocusNode();
  final AuthController authC = Get.put(AuthController());

  
  Future pickImage(String type, ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await cropImage(
        imageFile: img,
        type: type
      );
      setState(() {
        avatar = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      AppHelper.loggerNoStack.v(e);
      Navigator.of(context).pop();
    }
  }
  
  Future<File?> cropImage({required File imageFile, required String type}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: (type == 'ktp') ? const CropAspectRatio(ratioX: 16, ratioY: 9) : const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }


  @override
  void initState() {

    // AppHelper.loggerNoStack.v();
    super.initState();
  }


  @override
  void dispose() {
    Loader.hide();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Aktivitas"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppStyles.colorWhite, 
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
        ),
        child: SingleChildScrollView(
          child: Form(
            key: activityFormKey,
            autovalidateMode: AutovalidateMode.always,
            child: Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  UploadFotoDukunganWidget(
                    image: avatar,
                    onTap: (v) => pickImage('avatar', v),
                  ),

                  const SizedBox(height: 10,),

                  Obx(() =>
                    CustomDatePicker(
                      errorText: c.errorForm['date'],
                      label: "Tanggal", 
                      placeholder: "Pilih Tanggal Aktivitas",
                      maxTime: DateTime.now(),
                      currentTime: DateTime.now(),
                      selected: dateC,
                      onSelect: (v){
                        setState(() {
                          dateC = v;
                        });
                      }
                    )
                  ),
                  const SizedBox(height: 10,),
                  
                  Obx(() => CustomFormField(
                    headingText: "Alamat",
                    hintText: "Masukan Alamat",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: descriptionC,
                    focusNode: _alamatFocus,
                    onFieldSubmitted: (term) async {
                      if(activityFormKey.currentState!.validate()) {
                        AppHelper().showLoading(context);
                        _submit();
                      }
                    },
                    maxLines: 3,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.streetAddress,
                    errorText: c.errorForm['alamat'],
                  )),
                  const SizedBox(height: 10,),

                  CustomButton(
                    buttonText: "Simpan", 
                    onPressed: () async {
                      if(activityFormKey.currentState!.validate()) {
                        AppHelper().showLoading(context);
                        _submit();
                      }
                    },
                  ),


                ],
              ),
            ),
          )
        ),
      )
    );
  }

  Future _submit() async {
    // AppHelper.loggerNoStack.v(dateC);
    Map<String, dynamic> data = {
        "date" : (dateC != null ) ? DateFormat('yyyy-MM-dd').format(dateC!) : "",
        "description" : descriptionC.text,
        "project_id" : Get.parameters['project']
    };

    if(avatar != null){
      if (avatar == null) return;
      File image = File(avatar!.path);
      String avatarName = image.path.split('/').last;
      data["image"] = await dio.MultipartFile.fromFile(avatar!.path, filename: avatarName);
    }
    c.store(data);
    return true;
  }
}