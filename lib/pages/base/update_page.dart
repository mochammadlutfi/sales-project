import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/core_export.dart';

class UpdatePage extends StatelessWidget {
  final bool? isUpdate;
  const UpdatePage({super.key, this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.colorWhite,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.update,
              width: 250,
            ),
            const SizedBox(height: 30),
            const Text("Versi Terbaru Tersedia",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            
            const Center(
              child: Text("Perbarui aplikasi kami ke versi terbaru untuk pengalaman yang lebih baik",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'Update Sekarang',
              onPressed:  ()  async {
              String appUrl = 'https://play.google.com/store/apps/details?id=com.app.jawaracaleg';
              bool canLaunch = await canLaunchUrl(Uri.parse(appUrl));
              if (canLaunch) {
                _launchUrl(Uri.parse(appUrl));
              } else {
                AppHelper.showSnackbar('error', 'Tidak Bisa Terhubung Ke $appUrl', SnackPosition.BOTTOM);
              }
              },
            )
          ],
        ),
      ),
    );
  }

  
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}