
import 'package:flutter/services.dart';

import '../core/core_export.dart';

class CustomFormField extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;
  final String? errorText;
  final String? Function(String?)? onValidate;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    Key? key,
    required this.headingText,
    required this.hintText,
    required this.obsecureText,
    required this.suffixIcon,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.maxLines,
    this.errorText,
    this.onFieldSubmitted,
    this.focusNode,
    this.onValidate,
    this.onChanged,
    this.inputFormatters
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Text(
            headingText,
            style: AppStyles.textFieldHeading,
          ),
        ),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          maxLines: maxLines,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          obscureText: obsecureText,
          focusNode: focusNode,
          validator: onValidate,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          decoration: InputDecoration(
              contentPadding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: hintText,
              errorText : errorText,
              hintStyle: AppStyles.textFieldHintStyle,
              suffixIcon: suffixIcon,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppStyles.colorGray, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppStyles.colorPrimary,
                  width: 1,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppStyles.colorDanger,
                  width: 1,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppStyles.colorDanger,
                  width: 1,
                ),
              ),
          ),
        )
      ],
    );
  }
}