import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/text_styles/text_style.dart';
import '../../../../../core/utils/api_consatance.dart';
import '../../../../../core/utils/app_constance/color_constance.dart';
import '../../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../core/utils/app_constance/app_constance.dart';
import '../../../../core/widgets/custom_failure.dart';
import '../../../../core/widgets/custom_navigation.dart';
import '../../../current_movie/screens/cureent_movie.dart';
import '../../controllers/home_screen_bloc.dart';
import '../../controllers/home_screen_state.dart';

class CoverImagesMovieWidget extends StatelessWidget {
  final Size media;

  CoverImagesMovieWidget({super.key, required this.media});
  final scrollController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        switch (state.requestSatutsAiringToday) {
          case RequestSatuts.loading:
            return Container();

          case RequestSatuts.loaded:
            return Column(
              children: [
                SizedBox(
                  width: media.width,
                  height: media.height * .67,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    itemCount: state.airingTodayMovie.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AnimationRoute.fadeRoute(context,
                              pageRoute: CurrentMovieScreen(
                                cureentMovie: state.airingTodayMovie[index],
                              ));
                        },
                        child: Column(
                          children: [
                            ShaderMask(
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
                                Rect.fromLTRB(media.height * .03, 0,
                                    bounds.width * .09, bounds.height),
                              ),
                              child: SizedBox(
                                height: media.height * .6,
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) => SizedBox(
                                    width: media.width,
                                    height: media.height * .65,
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
                                    state.airingTodayMovie[index].posterPath!,
                                  ),
                                  fadeInCurve: Curves.bounceInOut,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => Center(
                                    child: Image.asset(
                                      IconConstance.iWarningIcon,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                left: 15,
                              ),
                              child: Text(
                                state.airingTodayMovie[index].overview
                                        ?.toString() ??
                                    "Cover",
                                maxLines: 2,
                                style: homeScreenTextStyleAuthScreens.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: SmoothPageIndicator(
                    axisDirection: Axis.horizontal,
                    controller: scrollController,
                    count: state.airingTodayMovie.length,
                    effect: ExpandingDotsEffect(
                      spacing: 8.0,
                      dotHeight: 5.0,
                      dotWidth: 15.0,
                      expansionFactor: 3.0,
                      dotColor: Colors.black54,
                      activeDotColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            );
          case RequestSatuts.failure:
            return FailureWidget(
              onRefresh: () async {},
            );

          case RequestSatuts.empty:
            return Container();
        }
      },
    );
  }
}
