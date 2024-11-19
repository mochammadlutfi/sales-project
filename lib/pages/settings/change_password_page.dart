import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../core/core_export.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserController c = Get.put(UserController());
  TextEditingController oldPassword= TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConf = TextEditingController();
  bool ishideOldPassword = true;
  bool isHideNewPassword = true;
  bool isHideNewPasswordConf = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pencalonan"),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          decoration: const BoxDecoration(
            color: AppStyles.colorWhite, 
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
          ),
          child: GetBuilder<UserController>(
          initState :(_){
          },
          builder: (c){
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  height: Get.height - 90,
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: AppStyles.colorWhite, 
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomFormField(
                        headingText: "Password Lama",
                        hintText: "Masukan Password Lama",
                        obsecureText: ishideOldPassword,
                        suffixIcon: IconButton(
                            icon: Icon(!ishideOldPassword ? Icons.visibility_off : Icons.visibility),
                            splashColor: Colors.transparent,
                            onPressed: (){
                              setState(() {
                                ishideOldPassword = !ishideOldPassword;
                              });
                            } 
                        ),
                        controller: oldPassword,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        onValidate: (String? v){
                          return FormValidation().isEmpty(v!, "Password Lama Wajib Diisi!");
                        },
                      ),
                      const SizedBox(height: 10,),

                      CustomFormField(
                        headingText: "Password Baru",
                        hintText: "Masukan Password Baru",
                        obsecureText: isHideNewPassword,
                        suffixIcon: IconButton(
                            icon: Icon(!isHideNewPassword ? Icons.visibility_off : Icons.visibility),
                            splashColor: Colors.transparent,
                            onPressed: (){
                              setState(() {
                                isHideNewPassword = !isHideNewPassword;
                              });
                            }
                        ),
                        controller: password,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        onValidate: (String? v){
                          return FormValidation().isEmpty(v!, "Password Baru Wajib Diisi!");
                        },
                      ),
                      const SizedBox(height: 10,),
                      
                      CustomFormField(
                        headingText: "Konfirmasi Password Baru",
                        hintText: "Masukan Konfirmasi Password Baru",
                        obsecureText: isHideNewPasswordConf,
                        suffixIcon: IconButton(
                            icon: Icon(!isHideNewPasswordConf ? Icons.visibility_off : Icons.visibility),
                            splashColor: Colors.transparent,
                            onPressed: (){
                              setState(() {
                                isHideNewPasswordConf = !isHideNewPasswordConf;
                              });
                            }
                        ),
                        controller: passwordConf,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        onValidate: (String? v){
                          return FormValidation().isEmpty(v!, "Konfirmasi Password Baru Wajib Diisi!");
                        },
                      ),

                      const SizedBox(height: 10,),
                      CustomButton(
                        buttonText: "Simpan", 
                        onPressed: () async {
                          if(formKey.currentState!.validate()) {
                            // AppHelper().showLoading(context);
                            c.updatePassword(oldPassword.text, password.text);
                          }
                        },
                      ),


                    ],
                  ),
                ),
              )
            );
        }),
        )
      )
    );
  }
}