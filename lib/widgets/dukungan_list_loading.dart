import 'package:shimmer/shimmer.dart';

import '../core/core_export.dart';

class DukunganListLoading extends StatelessWidget {
  final int count;
  const DukunganListLoading({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: AppStyles.colorGrayShade,
        highlightColor: AppStyles.bgColor,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: count,
          itemBuilder: (_, __) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppStyles.colorGrayShade,
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2,
                        height: 14,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 6,),

                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 6,),

                      Container(
                        width: 180,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}