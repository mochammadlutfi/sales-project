import '../../core/core_export.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SelectGenderWidget extends StatelessWidget {
  final String? selected;
  final Function(String) onSelect;
  final String? Function(String?)? onValidate;
  final String? errorText;
  const SelectGenderWidget({Key? key, required this.selected, required this.onSelect, this.onValidate, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: const Text(
            "Jenis Kelamin",
            style: AppStyles.textFieldHeading,
          ),
        ),
        DropdownSearch<String>(
          validator: onValidate,
          selectedItem: selected,
          onChanged: (value){
            if(value != null){
              onSelect(value);
            }
          },
          items: const ["Laki-Laki", "Perempuan"],
          dropdownDecoratorProps : DropDownDecoratorProps(
            baseStyle: const TextStyle(
              fontSize: 16,
            ),
            dropdownSearchDecoration: InputDecoration(
              hintText: "Pilih Jenis Kelamin",
              errorText: errorText,
              contentPadding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintStyle: AppStyles.textFieldHintStyle,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppStyles.colorGray, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppStyles.colorPrimary,
                  width: 2,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppStyles.colorDanger,
                  width: 1,
                ),
              ),
            ),
          ),
          popupProps: PopupProps.modalBottomSheet(
            constraints : const BoxConstraints(maxHeight: 200),
            itemBuilder: _wrapperModal,
            containerBuilder: (ctx, popupWidget) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 60.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppStyles.colorGrayShade,
                        ), 
                      ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    child: Text("Pilih Jenis Kelamin", 
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
            modalBottomSheetProps : const ModalBottomSheetProps(
              backgroundColor: AppStyles.colorWhite,
              elevation: 2,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppStyles.colorWhiteShade,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), 
                  topRight: Radius.circular(25),
                )
              ) 
            ),
          ),
        ),
      ],
    );
  }

  
  Widget _wrapperModal(BuildContext context, String item, bool isSelected) {
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item),
      ),
    );
  }
}