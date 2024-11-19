
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:pds/pages/wilayah/branch_select_page.dart';

import '../../controllers/project_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../core/core_export.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../../models/branch_model.dart';
import '../../models/sales_model.dart';
import '../wilayah/sales_select_page.dart';

class ProjectCreatePage extends StatefulWidget {
  const ProjectCreatePage({Key? key}) : super(key: key);

  @override
  State<ProjectCreatePage> createState() => _ProjectCreatePageState();
}

class _ProjectCreatePageState extends State<ProjectCreatePage> {
  final ProjectController c = Get.put(ProjectController());
  final GlobalKey<FormState> dukunganFormKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController customerNameC = TextEditingController();
  TextEditingController customerPhoneC = TextEditingController();
  TextEditingController customerEmailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController cpNameC = TextEditingController();
  TextEditingController cpPhoneC = TextEditingController();
  TextEditingController cpPositionC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  BranchModel? branch;
  SalesModel? sales;                      
  bool salesEnable = false;
  bool? isReady = false;

  final FocusNode _nameFocus = FocusNode();  
  final FocusNode _customerNameFocus = FocusNode();  
  final FocusNode _customerPhoneFocus = FocusNode();  
  final FocusNode _customerEmailFocus = FocusNode();
  final FocusNode _customerAddressFocus = FocusNode();
  final FocusNode _cpNameFocus = FocusNode();
  final FocusNode _cpPositionFocus = FocusNode();
  final FocusNode _cpPhoneFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();
  final AuthController authC = Get.put(AuthController());
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp ',
  );

  

  @override
  void initState() {
    // AppHelper.loggerNoStack.v(filterKel);

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
        title: const Text("Tambah Project"),
      ),
      backgroundColor: AppStyles.colorPrimary,
      body: Container(
        decoration: const BoxDecoration(
          color: AppStyles.colorWhite, 
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: SingleChildScrollView(
          child: Form(
            key: dukunganFormKey,
            autovalidateMode: AutovalidateMode.always,
            child: Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                    const SizedBox(height: 10,),
                    Obx(() => CustomFormField(
                      headingText: "Nama Project",
                      hintText: "",
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: nameC,
                      focusNode: _nameFocus,
                      onFieldSubmitted: (term){
                        _fieldFocusChange(context, _nameFocus, _customerNameFocus);
                      },
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      errorText: c.errorForm['nama'],
                      )
                    ),
                    const SizedBox(height: 10,),

                  Obx(() => CustomFormField(
                    headingText: "Alamat Proyek",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: addressC,
                    focusNode: _customerAddressFocus,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.streetAddress,
                    errorText: c.errorForm['address'],
                  )),
                  const SizedBox(height: 10,),

                  Obx(() => CustomFormField(
                    headingText: "Nama Konsumen",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: customerNameC,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    errorText: c.errorForm['customer_name'],
                  )),
                  const SizedBox(height: 10,),

                  Obx(() => CustomFormField(
                    headingText: "No Telepon Konsumen",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: customerPhoneC,
                    focusNode: _customerPhoneFocus,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(context, _customerPhoneFocus, _customerEmailFocus);
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    errorText: c.errorForm['customer_phone'],
                  )),
                  const SizedBox(height: 10,),
                  
                  Obx(() => CustomFormField(
                    headingText: "Email Konsumen",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: customerEmailC,
                    focusNode: _customerEmailFocus,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(context, _customerEmailFocus, _customerAddressFocus);
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    errorText: c.errorForm['customer_email'],
                  )),
                  const SizedBox(height: 10,),

                  
                  
                  Obx(() => CustomFormField(
                    headingText: "Nama CP",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: cpNameC,
                    focusNode: _cpNameFocus,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(context, _cpNameFocus, _cpPositionFocus);
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    errorText: c.errorForm['cp_name'],
                  )),
                  const SizedBox(height: 10,),
                  
                  Obx(() => CustomFormField(
                    headingText: "Posisi CP",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: cpPositionC,
                    focusNode: _cpPositionFocus,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(context, _cpPositionFocus, _cpPhoneFocus);
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    errorText: c.errorForm['cp_position'],
                  )),
                  const SizedBox(height: 10,),

                  Obx(() => CustomFormField(
                    headingText: "No Telepon CP",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: cpPhoneC,
                    focusNode: _cpPhoneFocus,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(context, _cpPhoneFocus, _amountFocus);
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    errorText: c.errorForm['cp_phone'],
                  )),

                  const SizedBox(height: 10,),

                  Obx(() => CustomFormField(
                    headingText: "Nilai Project",
                    hintText: "",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: amountC,
                    focusNode: _amountFocus,
                    onFieldSubmitted: (term){
                      // _fieldFocusChange(context, _cpPhoneFocus, _amountFocus);
                    },
                    maxLines: 1,
                    inputFormatters: [_formatter],
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    errorText: c.errorForm['amount'],
                  )),
                  const SizedBox(height: 10,),

                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: isReady,
                          onChanged: (bool? value) {
                            setState(() {
                              isReady = value;
                            });
                          },
                        ), 
                        const SizedBox(width: 10),

                        const Text(
                          'is ready?',
                          style: TextStyle(fontSize: 17.0),
                        ), //Text
                        /** Checkbox Widget **/
                      ],
                    ),

                  CustomButton(
                    buttonText: "Simpan", 
                    onPressed: () async {
                      if(dukunganFormKey.currentState!.validate()) {
                        // AppHelper().showLoading(context);
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

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
}

  Future _submit() async {
    Map<String, dynamic> data = {
        "name": nameC.text,
        "address" : addressC.text,
        "customer_name": customerNameC.text,
        "customer_phone": cpNameC.text,
        "customer_email" : cpNameC.text,
        "cp_name" : cpNameC.text,
        "cp_position" : cpPositionC.text,
        "cp_phone" : cpPhoneC.text,
        "amount" : _formatter.getUnformattedValue(),
        "branch_id" : branch?.id,
        "sales_id" : sales?.id,

    };
  // AppHelper.loggerNoStack.v();
    c.store(data);
    return true;
  }
}