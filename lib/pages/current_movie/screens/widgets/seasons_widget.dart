import 'package:flutter/material.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/app_constance/color_constance.dart';

class SeasonsWidgets extends StatelessWidget {
  final int seasonNumber;
  final Size media;
  const SeasonsWidgets(
      {super.key, required this.media, required this.seasonNumber});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: seasonNumber,
      child: Column(
        children: [
          SizedBox(
            width: media.width,
            height: media.height,
            child: TabBarView(
              children: <Widget>[],
            ),
          ),
          TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: ColorConstance.cDefaultColor,
            unselectedLabelColor: Colors.white38,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            splashBorderRadius: BorderRadius.circular(20),
            labelStyle: defaultStyleSize,
            tabs: const [
              Tab(text: "For you"),
              Tab(text: "All Shows"),
              Tab(text: "Movies"),
              Tab(text: "TV shows"),
            ],
          ),
        ],
      ),
    );
  }
}
