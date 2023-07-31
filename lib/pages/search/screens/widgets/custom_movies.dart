import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/app_constance/app_constance.dart';
import '../../../../core/widgets/custom_failure.dart';
import '../../controllers/search_bloc.dart';
import '../../controllers/search_state.dart';
import 'cusotm_loading_search.dart';
import 'custom_loaded_search.dart';

class MoviesWidget extends StatelessWidget {
  final Animation<double> opacity;
  final Size media;
  const MoviesWidget({super.key, required this.opacity, required this.media});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<SearchBloc>(context);

        switch (state.requestSatutsAllShows) {
          case RequestSatuts.loading:
            return LoadingSearchWidget(opacity: opacity);
          case RequestSatuts.loaded:
            return SizedBox(
              height: media.height,
              child: LoadedSearchWidget(
                event: LoadMoreDataMoviesEvent(),
                getData: state.getMoreResults,
                count: state.movieList.length,
                listOfMoviesOfResults: state.movieList,
                onRefresh: () async {
                  bloc.add(const GetMoviesEvent());
                },
              ),
            );
          case RequestSatuts.empty:
            return Center(
                child: Text(
              "This Page will be Follow the search results for you",
              textAlign: TextAlign.center,
              style: defaultStyleSize.copyWith(
                  color: Theme.of(context).primaryColor),
            ));
          case RequestSatuts.failure:
            return FailureWidget(
              onRefresh: () async {
                bloc.add(const GetTvShowsEvent());
              },
            );
        }
      },
    );
  }
}
