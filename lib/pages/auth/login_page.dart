
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/core_export.dart';

class LoginPage extends StatefulWidget {
  final bool exitFromApp;
  const LoginPage({Key? key, required this.exitFromApp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();


  @override
  void initState() {
    requestFocus();
    super.initState();
  }

  requestFocus() async{
    Timer(const Duration(seconds: 1), () {
      _emailFocus.requestFocus();
    });
  }
  
  @override
  Widget build(BuildContext context) {
  
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
          Fluttertoast.showToast(
            msg: 'Tekan Sekali Lagi Untuk Keluar',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
          return false;
      },
      child: Scaffold(
        backgroundColor: AppStyles.colorWhite,
        body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: GetBuilder<AuthController>( 
              builder: (authController) {
                return Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
            //           /// app icon
                      SizedBox(height: height * 0.05),
                      Image.asset(
                        AppImages.logoVer,
                        height: 200,
                      ),

                      // /// email field
                      SizedBox(height: height * 0.1),
                      CustomFormField(
                        headingText: "Username",
                        hintText: "Masukan Username",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        controller: authController.loginEmailController,
                        maxLines: 1,
                        focusNode: _emailFocus,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        onValidate: (String? v){
                          return FormValidation().isEmpty(v!, "Username Wajib Diisi!");
                        },
                      ),

                      // /// password field
                      SizedBox(height: height * 0.02),
                      CustomFormField(
                        headingText: "Password",
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        focusNode: _passwordFocus,
                        hintText: "Masukan Password",
                        obsecureText: authController.isHidePassword,
                        suffixIcon: IconButton(
                            color: AppStyles.colorPrimary,
                            icon: Icon(!authController.isHidePassword ? Icons.visibility_off : Icons.visibility),
                            splashColor: Colors.transparent,
                            onPressed: (){
                              authController.toggleHidePassword();
                            } 
                        ),
                        onFieldSubmitted: (v){
                          if(loginKey.currentState!.validate()) {
                            AppHelper().showLoading(context);
                            _login(authController);
                          }
                        },
                        controller: authController.loginPasswordController,
                        onValidate: (String? v){
                          return FormValidation().isEmpty(v!, "Password Wajib Diisi!");
                        },
                      ),
                      const SizedBox(
                        height: AppStyles.paddingSizeLARGE
                      ),
                      // !authController.isLoading! ?
                      CustomButton(
                        buttonText: 'Login Sekarang',
                        onPressed:  ()  {
                          if(loginKey.currentState!.validate()) {
                            AppHelper().showLoading(context);
                            _login(authController);
                          }
                        },
                      )
                    ],
                  ),
                );
              }
            ),
          ),
        ),
      ),
      ),
    );
  }
  
  void _login(AuthController authController) async {
    authController.login();
  }
}