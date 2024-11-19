import '../core/core_export.dart';
import '../models/contact_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactListItem extends StatelessWidget {
  final ContactModel item;
  final GestureTapCallback? onTap;
  final Function(BuildContext)? onEdit;
  final Function(BuildContext)? onRemove;
  const ContactListItem({super.key, required this.item, this.onTap, this.onEdit, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      elevation: 0.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: AppStyles.colorGrayShade,
        ),
      ),
      color: AppStyles.colorWhite,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Slidable(
          key: Key('$item'),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: onEdit,
                backgroundColor: Colors.teal,
                icon: Icons.edit,
                label: "Ubah",
              ),
              SlidableAction(
                onPressed: onRemove,
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: "Hapus",
              ),
            ],
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            title: Text(item.name ?? "Nama Contact",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.phone ?? "No Handphone",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                  ),
                )
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: onTap,
        ),
        ),
      )
      
    );
  }
}