// ignore_for_file: avoid_print, null_check_always_fails


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bottom_navigation_bar.dart';
import '../../../core/services/service_get_it.dart';
import '../../../core/text_styles/text_style.dart';
import '../../../core/utils/api_consatance.dart';
import '../../../core/utils/app_constance/app_constance.dart';
import '../../../core/utils/app_constance/color_constance.dart';
import '../../../core/utils/app_constance/icon_constance.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_navigation.dart';
import '../../../main.dart';
import '../controller/intersting_movie_bloc.dart';

import '../controller/intersting_movie_event.dart';
import '../controller/intersting_movie_state.dart';
import 'widgets/custom_failure_intersting_movie_screen.dart';
import 'widgets/custom_loading_intersting_movie_screen.dart';

class InterstingMovieScreen extends StatefulWidget {
  const InterstingMovieScreen({super.key});

  @override
  State<InterstingMovieScreen> createState() => _InterstingMovieScreenState();
}

class _InterstingMovieScreenState extends State<InterstingMovieScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: BlocProvider(
            create: (context) => sl<InterstingMovieBloc>()
              ..add(
                LoadGetInterstingMovieEvent(),
              ),
            child: BlocConsumer<InterstingMovieBloc, InterstingMovieState>(
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.request) {
                  case RequestSatuts.empty:
                    return Container();
                  case RequestSatuts.loading:
                    return const InterstingMovieLoadingStatuWidget();
                  case RequestSatuts.loaded:
                    final bloc = BlocProvider.of<InterstingMovieBloc>(context);
                    return Stack(children: [
                      Positioned.fill(
                        child: CustomScrollView(
                          shrinkWrap: true,
                          slivers: [
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 30),
                            ),
                            SliverToBoxAdapter(
                              child: Text(
                                "Choose 3 or more shows that interest you",
                                style: largeStyleSize.copyWith(
                                  fontSize: 35,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 15)),
                            SliverToBoxAdapter(
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 3 / 4.5,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3,
                                ),
                                itemCount: state.interstingMovieModel!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      print(state
                                          .interstingMovieModel![index].id);
                                      bloc.add(SelectItemEvent(index: index));
                                      // final data = state.interstMovieList
                                      //     .firstWhere((element) =>
                                      //         element ==
                                      //         state.interstingMovieModel!
                                      //             .results![index].id);
                                      // print(data);
                                      // print(state.interstMovieList);
                                      // if (data ==
                                      //     state.interstingMovieModel!
                                      //         .results![index].id) {
                                      //   print("object");
                                      // }
                                    },
                                    child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      curve: Curves.linear,
                                      reverseDuration:
                                          const Duration(milliseconds: 1500),
                                      child: Container(
                                        width: 200,
                                        height: 600,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  width: 100,
                                                  height: 200,
                                                  progressIndicatorBuilder:
                                                      (context, url, progress) {
                                                    return Center(
                                                        child: CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            color: ColorConstance
                                                                .cDefaultColor,
                                                            backgroundColor:
                                                                ColorConstance
                                                                    .cDefaultColor
                                                                    .withOpacity(
                                                                        .05)));
                                                  },
                                                  imageUrl:
                                                      ApiConstance.imageUrl(
                                                    state
                                                        .interstingMovieModel![
                                                            index]
                                                        .posterPath!,
                                                  ),
                                                  fadeInCurve:
                                                      Curves.bounceInOut,
                                                  fit: BoxFit.fill,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                    child: Image.asset(
                                                      IconConstance
                                                          .iWarningIcon,
                                                      height: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            for (int i = 0;
                                                i <
                                                    state.interstMovieList
                                                        .length;
                                                i++)
                                              if (state.interstMovieList
                                                      .elementAt(i) ==
                                                  state
                                                      .interstingMovieModel![
                                                          index]
                                                      .id)
                                                Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: ColorConstance
                                                                .cDefaultColor),
                                                    child: const Icon(
                                                      Icons
                                                          .done_outline_rounded,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state.interstMovieList.length == 3)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customButton(
                                width: media.width,
                                text: "Done",
                                onPressed: () {
                                  prefs
                                      .setString("InterstingMovie",
                                          state.interstMovieList.toString())
                                      .whenComplete(() {
                                    print(
                                        "Intersting Movie List => ${prefs.getString("InterstingMovie")}");

                                    AnimationRoute.fadeRoutePushAndRemoveUntil(
                                      context,
                                      pageRoute:
                                          const BottomNavigationBarScreens(),
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                    ]);

                  case RequestSatuts.failure:
                    final bloc = BlocProvider.of<InterstingMovieBloc>(context);
                    return RefreshIndicator(
                        onRefresh: () async {
                          bloc.add(LoadGetInterstingMovieEvent());
                        },
                        child: ListView(children: const [
                          InterstingMovieFailureStatueWidget()
                        ]));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
