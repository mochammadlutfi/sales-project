
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../controllers/wilayah_controller.dart';
import '../../core/core_export.dart';
import '../../models/branch_model.dart';

class BranchSelect extends GetView<WilayahController> {
  final bool enabled;
  final BranchModel? selected;
  final Function(BranchModel) onSelect;
  final String? Function(BranchModel?)? onValidate;
  final String? errorText;

  const BranchSelect({
    Key? key,
    this.selected, 
    required this.onSelect, 
    this.enabled = true,
    this.onValidate,
    this.errorText,
    }): super(key: key);
      

  @override
  Widget build(BuildContext context) { 
    final controller = Get.put(WilayahController());
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: const Text(
            "Cabang",
            style: AppStyles.textFieldHeading,
          ),
        ),
        DropdownSearch<BranchModel>(
          validator: onValidate,
          enabled: enabled,
          selectedItem: selected,
          onChanged: (value){
            if(value != null){
              onSelect(value);
            }
          },
          itemAsString :(item) => item.name ?? "",
          asyncItems: (String? filter) => controller.getBranch(),
          compareFn: (i, s) => i.isEqual(s),
          dropdownDecoratorProps : DropDownDecoratorProps(
            baseStyle: const TextStyle(
              fontSize: 16,
            ),
            dropdownSearchDecoration: InputDecoration(
              errorText: errorText,
              hintText: "Pilih Cabang",
              contentPadding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintStyle: AppStyles.textFieldHintStyle,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppStyles.colorGray, width: 1),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppStyles.colorHintText, width: 1),
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
          ),
          popupProps: PopupPropsMultiSelection.modalBottomSheet(
            itemBuilder: _wrapperModal,
            containerBuilder: (ctx, popupWidget) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    child: Text("Pilih Cabang", 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),
                  Flexible(
                    child: Container(
                      child: popupWidget,
                    )
                  ),
                ],
              );
            },
            modalBottomSheetProps: const ModalBottomSheetProps(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14), 
                  topRight: Radius.circular(14),
                )
              ) 
            ),
          ),
        ),
      ],
    );
  }

  Widget _wrapperModal(BuildContext context, BranchModel item, bool isSelected) {
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name ?? ""),
      ),
    );
  }
}