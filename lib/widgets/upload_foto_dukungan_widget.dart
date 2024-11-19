import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/core_export.dart';

class UploadFotoDukunganWidget extends StatelessWidget {
  final File? image;
  final Function(ImageSource source) onTap;
  final String? imageNetwork;
  final String? source;

  const UploadFotoDukunganWidget({Key? key, this.image, required this.onTap, this.imageNetwork, this.source = 'local'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.bottomSheet( 
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera_alt_rounded),
                      title: const Text("Ambil dari kamera"),
                      onTap: () => onTap(ImageSource.camera),
                    ),
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text("Pilih dari galeri"),
                      onTap: () => onTap(ImageSource.gallery),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
            ),
            enableDrag: true,
          );
        },
        child : Container(
          width: 150,
          height: 180,
          decoration: BoxDecoration(
            color: AppStyles.colorWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2)
              ),
            ],
          ),
          child: Column(
            children: [
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: AppStyles.colorWhite,
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
              ),
              child: (image != null) ?
              ClipRRect(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                child: Image.file(
                  image!
                )
              )
              : (imageNetwork == null) ? 
              ClipRRect(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                child: Image.network(
                  AppImages.avatar
                ),
              )
               :
              CachedNetworkImage(
                imageUrl: imageNetwork!,
                imageBuilder: (context, imageProvider) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                    child: Image(
                      image: imageProvider,
                      gaplessPlayback: true,
                      fit: BoxFit.cover, 
                    )
                  );
                },
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            
            Container(
              width: 150,
              height: 30,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
              ),
              child: const Center(
                child: Text("Foto",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppStyles.colorWhite,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}