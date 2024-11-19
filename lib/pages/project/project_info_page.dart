
import '../../core/core_export.dart';

class ProjectInfoPage extends StatelessWidget {
  final ProjectModel? data;
  const ProjectInfoPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            plainText(
              label: "Nama Project", 
              value: data?.name ?? "-"
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Nama Konsumen", 
              value: data?.customerName ?? "-"
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Telepon Konsumen", 
              value: data?.customerPhone ?? "-",
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Email Konsumen", 
              value: data?.customerEmail ?? "-"
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Nama CP", 
              value: data?.cpName ?? "-"
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Posisi CP", 
              value: data?.cpPosition ?? "-"
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Telepon CP", 
              value: data?.cpPhone ?? "-"
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Nilai Project", 
              value: data?.amount.toString() ?? "-"
            ),
            const SizedBox(
              height: 20,
              child: Divider(),
            ),
            plainText(
              label: "Status Project", 
              value: data?.status ?? "-"
            ),

          ],
        ),
        )
      ),
    );
  }
  
  
  Widget plainText({
    required String label,
    required String value,
    context
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}