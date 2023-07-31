// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:play/core/utils/app_constance/app_constance.dart';
import 'package:play/pages/current_movie/controller/current_movie_bloc.dart';
import 'package:play/pages/current_movie/controller/current_movie_state.dart';
import 'package:play/pages/current_movie/screens/widgets/loading_state._cureent_movie.dart';
import 'package:play/pages/current_movie/screens/widgets/recommendation_movie_widget.dart';

import '../../../core/services/service_get_it.dart';
import '../../../core/text_styles/text_style.dart';
import '../../../core/widgets/custom_failure.dart';
import '../../../data/models/movie_model.dart';
import 'widgets/actors_widget.dart';
import 'widgets/information_movie_widget.dart';
import 'widgets/movie_images.dart';
import 'widgets/pervious_and_next_episode.dart';
import 'widgets/youtube_play_widget.dart';

class CurrentMovieScreen extends StatelessWidget {
  final MovieModel cureentMovie;
  CurrentMovieScreen({
    Key? key,
    required this.cureentMovie,
  }) : super(key: key);

  bool x = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<CurrentMovieBloc>()
          ..add(
            GetVedioIdEvent(
              movieId: cureentMovie.id!,
            ),
          ),
        child: BlocBuilder<CurrentMovieBloc, CurrentMovieState>(
          builder: (context, state) {
            switch (state.requestSatuts) {
              case RequestSatuts.loading:
                return const LoadingStateCurrnetMovie();

              case RequestSatuts.loaded:
                return CustomScrollView(
                  slivers: [
                    state.youtubeIdModel.isNotEmpty
                        ? SliverToBoxAdapter(
                            child: YouTubePlayerWidget(
                              vedioPath: state.youtubeIdModel,
                              media: media,
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: MovieImagesWidget(
                              imagesMovieModel: state.imagesMovieModel,
                              media: media,
                            ),
                          ),
                    SliverToBoxAdapter(
                      child: InformationDataWidget(
                        movieTilte: cureentMovie.name?.toString() ?? "",
                        overView: cureentMovie.overview?.toString() ?? "",
                        movieType: state.typeMovieModel.toList(),
                        media: media,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: PerviousAndNextEpisodeWidget(media: media),
                    ),
                    SliverToBoxAdapter(
                      child: ActorsWidget(media: media),
                    ),
                    SliverToBoxAdapter(
                      child: RecommendationMovieWidget(
                        media: media,
                        recommendationList: state.recommendationList,
                      ),
                    )
                  ],
                );

              case RequestSatuts.empty:
                return Center(
                    child: Text(
                  "state.message",
                  textAlign: TextAlign.center,
                  style: defaultStyleSize.copyWith(
                      color: Theme.of(context).primaryColor),
                ));
              case RequestSatuts.failure:
                return FailureWidget(
                  onRefresh: () async {},
                );
            }
          },
        ),
      ),
    );
  }
}
