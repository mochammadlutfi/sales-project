import 'package:flutter_svg/svg.dart';

import '../core/core_export.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.emptyIcon,
            height: 150,
            width: 150,
            fit: BoxFit.fill,
            color: AppStyles.colorPrimary,
          ),
          const SizedBox(height: 60),
          const Text("Opps!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppStyles.colorText,
            ),
          ),
          const SizedBox(height: 20),
          const Text("Data Tidak Ditemukan",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: AppStyles.colorText,
            ),
          )
        ],
      ),
    );
  }
}