import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play/pages/home_screen/controllers/home_screen_bloc.dart';
import 'package:play/pages/home_screen/controllers/home_screen_state.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/app_constance/app_constance.dart';
import '../../../../core/widgets/custom_failure.dart';
import 'custom_categrois.dart';

class TopRatedWidget extends StatelessWidget {
  final Size media;
  const TopRatedWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        switch (state.requestSatutsTopRated) {
          case RequestSatuts.loading:
            return Container();
          case RequestSatuts.loaded:
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Top Rated Movie",
                        style: smallStyleSize.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                CarouselSlider(
                  items: [
                    CategoriesWidegt(
                        media: media,
                        movie: state.cartoonMovie,
                        collectionTitle: "Cartoon"),
                    CategoriesWidegt(
                        media: media,
                        movie: state.actionMovie,
                        collectionTitle: "Action"),
                    CategoriesWidegt(
                        media: media,
                        movie: state.crimMovie,
                        collectionTitle: "Crim"),
                  ],
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .2,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 5,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
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
