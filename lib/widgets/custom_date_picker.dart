import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../core/core_export.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final String placeholder;
  final Function(DateTime) onSelect;
  final DateTime? selected;
  final DateTime? minTime;
  final DateTime? maxTime;
  final DateTime? currentTime;
  final String? errorText;

  const CustomDatePicker({
    Key? key, 
    required this.label, 
    required this.placeholder, 
    required this.onSelect, 
    this.minTime, 
    this.maxTime,
    this.currentTime,
    this.selected,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 6,
          ),
          child: Text(
            label,
            style: AppStyles.textFieldHeading,
          ),
        ),
        
        GestureDetector(
          onTap: () {
              DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: minTime,
                maxTime: maxTime,
                currentTime: currentTime,
                locale: LocaleType.id,
                onConfirm: onSelect
              );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border : Border.all(
                    color: (errorText != null)? AppStyles.colorDanger : AppStyles.colorGray,
                  ),
                ),
                child: Text(selected == null ? placeholder : DateFormat('dd MMMM yyyy').format(selected!),
                  style: selected == null ? AppStyles.textFieldHintStyle : AppStyles.textFieldHeading,
                ),
              ),
              if(errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 10),
                child: Text(errorText!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppStyles.colorDanger,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          )
        ),
      ],
    );
  }
}