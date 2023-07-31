// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:play/data/models/movie_model.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../core/widgets/custom_navigation.dart';
import '../../../current_movie/screens/cureent_movie.dart';

class ListViewBuilderWidget extends StatelessWidget {
  final String title;

  final List<MovieModel?>? movie;

  final void Function()? onTap;

  final Size media;
  const ListViewBuilderWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.movie,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: media.height * .02, left: 10),
      child: SizedBox(
        width: media.width,
        height: media.height * .38,
        // color: Colors.red,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: smallStyleSize.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
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
            Expanded(
              flex: 4,
              child: ListView.builder(
                  itemCount: movie!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          AnimationRoute.fadeRoute(context,
                              pageRoute: CurrentMovieScreen(
                                cureentMovie: movie![index]!,
                              ));
                        },
                        child: SizedBox(
                          width: media.width * .4,
                          // color: Colors.green,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  height: media.height * .28,
                                  width: media.width,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: ColorConstance.cDefaultColor,
                                        backgroundColor: ColorConstance
                                            .cDefaultColor
                                            .withOpacity(.05),
                                      ),
                                    ),
                                  ),
                                  imageUrl: ApiConstance.imageUrl(
                                    movie![index]!.posterPath!,
                                  ),
                                  fadeInCurve: Curves.bounceInOut,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      SizedBox(
                                    width: media.width * .35,
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: media.width * .34,
                                // color: Colors.amber,
                                child: Text(
                                  movie![index]!.name?.toString() ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:
                                      homeScreenTextStyleAuthScreens.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
