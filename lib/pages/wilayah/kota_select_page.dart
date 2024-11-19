import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../controllers/wilayah_controller.dart';
import '../../core/core_export.dart';

class KotaSelect extends GetView<WilayahController> {
  final bool enabled;
  final String? parentId;
  final KotaModel? selected;
  final Function(KotaModel) onSelect;
  final String? Function(KotaModel?)? onValidate;

  const KotaSelect({
    Key? key, 
    this.parentId, 
    this.selected, 
    required this.onSelect, 
    this.enabled = true,
    this.onValidate
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
            "Kota / Kabupaten",
            style: AppStyles.textFieldHeading,
          ),
        ),
        DropdownSearch<KotaModel>(
          validator: onValidate,
          enabled: enabled,
          selectedItem: selected,
          onChanged: (value){
            if(value != null){
              onSelect(value);
            }
          },
          itemAsString :(item) => item.nama ?? "",
          asyncItems: (String? filter) => controller.getKota(parentId),
          compareFn: (i, s) => i.isEqual(s),
          dropdownDecoratorProps : const DropDownDecoratorProps(
            baseStyle: TextStyle(
              fontSize: 16,
            ),
            dropdownSearchDecoration: InputDecoration(
              hintText: "Pilih Kota/Kabupaten",
              contentPadding : EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintStyle: AppStyles.textFieldHintStyle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppStyles.colorGray, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppStyles.colorHintText, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppStyles.colorPrimary,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppStyles.colorDanger,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
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
            showSearchBox : true,
            searchFieldProps: TextFieldProps(
              controller: controller.searchController,
              decoration: InputDecoration(
                filled : true,
                fillColor: AppStyles.bgColor,
                contentPadding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border : const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppStyles.colorGrayShade, width: 1),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppStyles.bgColor, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: AppStyles.colorPrimary,
                    width: 1,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.searchController.clear();
                  },
                ),
              ),
            ),
            containerBuilder: (ctx, popupWidget) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    child: Text("Pilih Kota", 
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

  Widget _wrapperModal(BuildContext context, KotaModel item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.nama ?? ""),
      ),
    );
  }
}