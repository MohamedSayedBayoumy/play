import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play/pages/home_screen/controllers/home_screen_bloc.dart';
import 'package:play/pages/home_screen/controllers/home_screen_state.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/app_constance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../core/widgets/custom_failure.dart';
 
class UpComingSoonWidget extends StatelessWidget {
  final Size media;
  const UpComingSoonWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        switch (state.requestSatutsComingSoon) {
          case RequestSatuts.loading:
            return Container();
          case RequestSatuts.loaded:
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: SizedBox(
                width: media.width,
                height: media.height * .36,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Coming soon Movie",
                            style: smallStyleSize.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "see all",
                              style: smallStyleSize.copyWith(
                                  color: Colors.white38),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        height: media.height * .3,
                        child: ListView.builder(
                            itemCount: state.comingSoonMovie.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  width: media.width * .35,
                                  // color: Colors.green,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: media.height * .28,
                                          width: media.width,
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  Center(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: ColorConstance
                                                    .cDefaultColor,
                                                backgroundColor: ColorConstance
                                                    .cDefaultColor
                                                    .withOpacity(.05),
                                              ),
                                            ),
                                          ),
                                          imageUrl: ApiConstance.imageUrl(
                                            state.comingSoonMovie[index]
                                                .posterPath!,
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
                                          state.comingSoonMovie[index].title
                                                  ?.toString() ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: homeScreenTextStyleAuthScreens
                                              .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
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
