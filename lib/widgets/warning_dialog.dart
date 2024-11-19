import 'package:flutter_svg/svg.dart';

import '../core/core_export.dart';

class WarningDialog extends StatelessWidget {
  final String icon;
  final Function()? onConfirm;
  final Function()? onCancel;
  const WarningDialog({super.key, required this.icon, this.onConfirm, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      color: AppStyles.colorPrimary,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Kamu Yakin?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: AppStyles.colorText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Data Yang Dihapus Tidak Bisa Dikembalikan!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppStyles.colorText,
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyles.colorDanger,
                              minimumSize: const Size(0, 45),
                            ),
                            onPressed: onConfirm,
                            child: const Text(
                              'Tidak',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyles.colorPrimary,
                              minimumSize: const Size(0, 45),
                            ),
                            onPressed: onConfirm,
                            child: const Text(
                              'Ya',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
        ),
      ],
    );
  }
}