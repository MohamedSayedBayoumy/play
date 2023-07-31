import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../data/models/images_movie_model.dart';

class MovieImagesWidget extends StatelessWidget {
  final Size media;
  final ImagesMovieModel? imagesMovieModel;

  const MovieImagesWidget(
      {super.key, required this.imagesMovieModel, required this.media});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                ColorConstance.cbackGroundColor,
                ColorConstance.cbackGroundColor,
                Colors.transparent,
              ],
              stops: [0, 0.3, .01, 5],
            ).createShader(
              Rect.fromLTRB(
                  media.height * .03, 0, bounds.width * .09, bounds.height),
            ),
        child: CarouselSlider.builder(
            options: CarouselOptions(
              height: media.height * .5,
            ),
            itemCount: 0,
            itemBuilder: (BuildContext context, int index, int realIndex) =>
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: media.width,
                    height: media.height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            color: ColorConstance.cDefaultColor,
                            backgroundColor:
                                ColorConstance.cDefaultColor.withOpacity(.05),
                          ),
                        ),
                        imageUrl: ApiConstance.imageUrl(
                            "/dZF7DTXgyoyshdALJLOrQ9Zj4Xz.jpg"),
                        fadeInCurve: Curves.bounceInOut,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                IconConstance.iWarningIcon,
                                height: 50,
                              ),
                              Text(
                                "Check your Internet Connection",
                                style: smallStyleSize.copyWith(
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
