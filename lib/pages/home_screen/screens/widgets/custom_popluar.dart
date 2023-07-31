import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_constance/app_constance.dart';
import '../../../../core/widgets/custom_failure.dart';
import '../../controllers/home_screen_bloc.dart';
import '../../controllers/home_screen_state.dart';
import 'custom_list_view.dart';

class PopluarWidget extends StatelessWidget {
  final Size media;

  const PopluarWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        switch (state.requestSatutsForYou) {
          case RequestSatuts.loading:
            return Container();

          case RequestSatuts.loaded:
            return ListViewBuilderWidget(
              media: media,
              onTap: () {},
              title: "Poplouar",
              movie: state.popularMovie,
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
