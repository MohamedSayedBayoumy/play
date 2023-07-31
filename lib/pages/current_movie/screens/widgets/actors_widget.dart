import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';

class ActorsWidget extends StatelessWidget {
  final Size media;
  final List<String>? casts;
  const ActorsWidget({super.key, required this.media, this.casts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Actors",
            style: defaultStyleSize.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: media.height * .25,
            width: media.width,

            // color: Colors.amber,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      height: 100,
                      width: 100,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ColorConstance.cDefaultColor,
                          backgroundColor:
                              ColorConstance.cDefaultColor.withOpacity(.05),
                        ),
                      ),
                      imageUrl: ApiConstance.imageUrl(
                        "/iG8EmXJsrqtfIonw9RHOX64aNJ9.jpg",
                      ),
                      fadeInCurve: Curves.bounceInOut,
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
                    const SizedBox(height: 5),
                    Text(
                      "Aline Machado",
                      style: homeScreenTextStyleAuthScreens.copyWith(
                        // fontSize: 13,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Barbara Reis",
                      style: smallTextStyleAuthScreens.copyWith(
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
