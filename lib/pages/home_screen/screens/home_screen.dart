import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_get_it.dart';
import '../../../core/utils/app_constance/app_constance.dart';
import '../../../core/widgets/custom_failure.dart';
import '../controllers/home_screen_bloc.dart';
import '../controllers/home_screen_event.dart';
import '../controllers/home_screen_state.dart';
import 'widgets/cover_movie_widget.dart';
import 'widgets/custom_loading_home_screen.dart';
import 'widgets/custom_popluar.dart';
import 'widgets/custom_special_for_you_widget.dart';
import 'widgets/top_rated_widget.dart';
import 'widgets/up_coming_soon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<HomeScreenBloc>()
          ..add(GetOnAirMovieEvent())
          ..add(GetSpecialMovieForUserEvent())
          ..add(GetPopluarMovieEvent())
          ..add(GetCollectionsEvent())
          ..add(GetUpComingMovieEvent()),
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          buildWhen: (previous, current) =>
              previous.requestSatuts != current.requestSatuts,
          builder: (context, state) {
            final bloc = BlocProvider.of<HomeScreenBloc>(context);
            switch (state.requestSatuts) {
              case RequestSatuts.loading:
                return const LoadingHomeScreenWidget();
              case RequestSatuts.loaded:
                final media = MediaQuery.of(context).size;

                return RefreshIndicator(
                  onRefresh: () async {},
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: CoverImagesMovieWidget(media: media)),
                      SliverToBoxAdapter(
                          child: SpecialforYouWidget(media: media)),
                      SliverToBoxAdapter(child: PopluarWidget(media: media)),
                      SliverToBoxAdapter(child: TopRatedWidget(media: media)),
                      SliverToBoxAdapter(
                          child: UpComingSoonWidget(media: media)),
                    ],
                  ),
                );
              case RequestSatuts.failure:
                return FailureWidget(
                  onRefresh: () async {
                    return bloc.add(GetOnAirMovieEvent());
                  },
                );
              case RequestSatuts.empty:
                return Container();
            }
          },
        ));
  }
}
