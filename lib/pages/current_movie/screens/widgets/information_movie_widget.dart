import 'package:flutter/material.dart';
import 'package:play/core/utils/app_constance/icon_constance.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../data/models/type_movie_model.dart';

class InformationDataWidget extends StatelessWidget {
  final String? movieTilte;
  final String? overView;
  final List<TypeMovieModel>? movieType;
  final Size media;
  const InformationDataWidget(
      {super.key,
      required this.movieTilte,
      required this.movieType,
      required this.media,
      required this.overView});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: media.width * .8,
                child: Text(
                  movieTilte?.toString() ?? "",
                  maxLines: 3,
                  style: defaultStyleSize.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  IconConstance.iSaveIcon,
                  color: Theme.of(context).primaryColor,
                  height: 25,
                ),
              ),
            ],
          ),
          customWidget(),
          const SizedBox(height: 15),
          overView!.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: media.width * .9,
                      child: Text(
                        overView?.toString() ?? "",
                        style: homeScreenTextStyleAuthScreens.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(),
        ],
      ),
    );
  }

  Widget customWidget() {
    if (movieType!.isNotEmpty) {
      if (movieType![0].descriptors!.isNotEmpty) {
        return Column(
          children: [
            const SizedBox(height: 15),
            Text(
              movieType![0]
                      .descriptors
                      ?.toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .toString() ??
                  " ",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: smallTextStyleAuthScreens.copyWith(
                color: Colors.white54,
              ),
            ),
          ],
        );
      } else {
        return const Center();
      }
    } else {
      return const Center();
    }
  }
}
