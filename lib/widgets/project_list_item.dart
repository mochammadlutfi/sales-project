import '../core/core_export.dart';

class ProjectListItem extends StatelessWidget {
  final ProjectModel item;
  final GestureTapCallback onTap;
  const ProjectListItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // AppHelper.loggerNoStack.v(item.toJson());

    return Card(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      elevation: 0.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: AppStyles.colorGrayShade,
        ),
      ),
      color: AppStyles.colorWhite,
      child: ListTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          title: Text(item.name ?? "Nama Project",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nama Konsumen",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal
                    ),
                  ),

                  Text(item.customerName ?? "Nama Konsumen",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ]
              ),
              const SizedBox(
                height: 20,
                child: Divider(height: 20),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nilai Project",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal
                    ),
                  ),

                  Text(item.amount ?? "Nama Konsumen",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ]
              ),
              // const SizedBox(
              //   height: 20,
              //   child: Divider(height: 20),
              // ),

            ],
          ),
          // trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
      ),
    );
  }
}