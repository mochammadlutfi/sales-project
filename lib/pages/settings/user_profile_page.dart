
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';

import '../../core/core_export.dart';
import '../wilayah/kota_select_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();
  

  
  final FocusNode _phoneFocus = FocusNode();  
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _tmpLahirFocus = FocusNode();
  final UserController c = Get.put(UserController());

  
  @override
  void initState() {
    Get.find<UserController>().getProfile();

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Profil"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: GetBuilder<UserController>(
          initState :(_){
          },
          builder: (c){
            return SingleChildScrollView(
              child : Form(
                key: updateProfileKey,
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 14, right: 14, top : 14, bottom: 14),
                      decoration: const BoxDecoration(
                        color: AppStyles.colorWhite, 
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
                      ),
                      child: Form(
                        child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            CustomFormField(
                              headingText: "Nama Lengkap",
                              hintText: "Masukan Nama Lengkap",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: c.namaC,
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              onValidate: (String? v){
                                return FormValidation().isEmpty(v!, "Nama Lengkap Wajib Diisi!");
                              },
                            ),
                            const SizedBox(height: 10,),

                            
                            CustomFormField(
                              headingText: "Username",
                              hintText: "Masukan Username",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: c.namaC,
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              onValidate: (String? v){
                                return FormValidation().isEmpty(v!, "Nama Lengkap Wajib Diisi!");
                              },
                            ),
                            const SizedBox(height: 10,),


                            CustomFormField(
                              headingText: "No Handphone",
                              hintText: "Masukan No Handphone",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: c.phoneC,
                              focusNode: _phoneFocus,
                              onFieldSubmitted: (term){
                                _fieldFocusChange(context, _phoneFocus, _emailFocus);
                              },
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                              onValidate: (String? v){
                                return FormValidation().isEmpty(v!, "No Handphone Wajib Diisi!");
                              },
                              onChanged: (v) {
                                // c.phoneC.text =  FormValidation().phoneValidate(v)!;
                                if(v.length > 11){
                                  c.phoneC.text =  FormValidation().phoneValidate(c.phoneC.text)!;
                                }
                              },
                            ),
                            const SizedBox(height: 10,),
                            
                            CustomFormField(
                              headingText: "Alamat Email",
                              hintText: "Masukan Alamat Email",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: c.emailC,
                              focusNode: _emailFocus,
                              onFieldSubmitted: (term){
                                _fieldFocusChange(context, _emailFocus, _tmpLahirFocus);
                              },
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(height: 10,),

        
                            KotaSelect(
                              onValidate: (v){
                                if(v == null){
                                  return 'Kota Wajib Diisi!';
                                }
                                return null;
                              },
                              selected: c.kota.value,
                              onSelect : (v){
                                c.kota.value = v;
                              },
                              // enabled: kotaEnable,
                            ),
                            
                            const SizedBox(height: 10,),
                            CustomButton(
                              buttonText: "Simpan", 
                              onPressed: () async {
                                if(updateProfileKey.currentState!.validate()) {
                                  // AppHelper().showLoading(context);

                                  c.updateProfile();
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ),
                  ] ,
                )
              ),
            );
          }
        )
      )
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }
  

  // Future _submit() async {

  //   Map<String, dynamic> data = {
  //       "nik": nikC.text,
  //       "nama": namaC.text,
  //       "jk": jkC,
  //       "tmp_lahir": tmpLahirC.text,
  //       "tgl_lahir" : DateFormat('yyyy-MM-dd').format(tglLahirC!),
  //       "phone" : phoneC.text,
  //       "email" : emailC.text,
  //       "alamat" : alamatC.text,
  //       "rt" : rtC.text,
  //       "rw" : rwC.text,
  //       "tps" : tpsC.text,
  //       "kota_id" : kota!.id,
  //       "kec_id" : kecamatan!.id,
  //       "kel_id" : kelurahan!.id,
  //   };

  //   if(avatar != null){
  //     if (avatar == null) return;
  //     File image = File(avatar!.path);
  //     String avatarName = image.path.split('/').last;
  //     data["image"] = await dio.MultipartFile.fromFile(avatar!.path, filename: avatarName);
  //   }
  //   c.updateProfile(data);
  //   // return true;
  // }
}