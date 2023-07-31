import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:play/core/text_styles/text_style.dart';

import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';

class PerviousAndNextEpisodeWidget extends StatelessWidget {
  final Size media;
  const PerviousAndNextEpisodeWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
      child: SizedBox(
        width: media.width,
        height: media.height * .2,
        // color: Colors.amber,
        child: Row(
          children: [
            Expanded(
                child:
                    customWidget(context, title: "Last Episode", backPath: "")),
            const SizedBox(width: 10),
            Expanded(
                child:
                    customWidget(context, title: "Next Episode", backPath: "")),
          ],
        ),
      ),
    );
  }

  customWidget(
    BuildContext context, {
    required String title,
    required String? backPath,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: smallStyleSize.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
                fontSize: 14),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              height: media.height * .15,
              width: media.width,
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorConstance.cDefaultColor,
                    backgroundColor:
                        ColorConstance.cDefaultColor.withOpacity(.05),
                  ),
                ),
              ),
              imageUrl: ApiConstance.imageUrl(
                "/6sp9bFcEjNmhK4hHI6l6P3GQsKD.jpg",
              ),
              fadeInCurve: Curves.bounceInOut,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => SizedBox(
                width: media.width * .35,
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconConstance.iWarningIcon,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
