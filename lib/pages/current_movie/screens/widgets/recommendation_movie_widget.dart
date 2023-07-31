import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:play/data/models/recommendation_model.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';

class RecommendationMovieWidget extends StatelessWidget {
  final List<RecommendationModel> recommendationList;
  final Size media;

  const RecommendationMovieWidget({super.key, required this.media, required this.recommendationList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: media.width,
      height: media.height * .43,
      alignment: Alignment.topCenter,
      // color: Colors.amber,s
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommendation",
                  style: smallStyleSize.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "see all",
                    style: smallStyleSize.copyWith(color: Colors.white38),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                width: media.width,
                height: media.height,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recommendationList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: media.width * .4,
                      height: media.height * .35,
                      // color: Colors.red,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: media.width * .4,
                            height: media.height * .3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                width: media.width * .35,
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConstance.cDefaultColor,
                                    backgroundColor: ColorConstance
                                        .cDefaultColor
                                        .withOpacity(.05),
                                  ),
                                ),
                                imageUrl: ApiConstance.imageUrl(
                                 recommendationList[index].posterPath!,
                                ),
                                fadeInCurve: Curves.bounceInOut,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Center(
                                  child: Image.asset(
                                    IconConstance.iWarningIcon,
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            recommendationList[index].name!,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: smallStyleSize.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            recommendationList[index].overview!,
                            style: smallTextStyleAuthScreens.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color:
                                    const Color.fromARGB(255, 167, 167, 167)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
