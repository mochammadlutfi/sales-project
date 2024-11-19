import 'package:cached_network_image/cached_network_image.dart';

import '../models/project_activity_model.dart';

import '../core/core_export.dart';

class ActivityListItem extends StatelessWidget {
  final ProjectActivityModel item;
  final GestureTapCallback onTap;
  
  const ActivityListItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.all(12.0),
        height: 100, 
        decoration: BoxDecoration(
          color: AppStyles.colorWhiteShade,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: CachedNetworkImage(
                  imageUrl: item.image!,
                  imageBuilder: (context, imageProvider) {
                    return ClipRRect( 
                      borderRadius: BorderRadius.circular(10), 
                      child: Image(
                        image: imageProvider,
                        gaplessPlayback: true,
                        fit: BoxFit.fitHeight, 
                      )
                    );
                  },
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.date!,
                      style: const TextStyle(
                        fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(item.description!,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 11,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}