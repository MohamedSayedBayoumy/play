import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play/core/text_styles/text_style.dart';
import 'package:play/core/utils/app_constance/app_constance.dart';
import 'package:play/pages/search/controllers/search_bloc.dart';
import 'package:play/pages/search/controllers/search_state.dart';

import '../../../../core/widgets/custom_failure.dart';
import 'cusotm_loading_search.dart';

class ForYouWidget extends StatelessWidget {
  final Animation<double> opacity;
  const ForYouWidget({required this.opacity, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.requestSatutsForYou) {
          case RequestSatuts.loading:
            return LoadingSearchWidget(opacity: opacity);
          case RequestSatuts.loaded:
            return LoadingSearchWidget(opacity: opacity);

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
              onRefresh: () async {},
            );
        }
      },
    );
  }
}
