import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/app_constance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../core/widgets/custom_failure.dart';
import '../../controllers/search_bloc.dart';
import '../../controllers/search_state.dart';
import 'cusotm_loading_search.dart';

class TvShowsWidgets extends StatefulWidget {
  final Animation<double> opacity;
  final Size media;
  const TvShowsWidgets({required this.opacity, super.key, required this.media});

  @override
  State<TvShowsWidgets> createState() => _TvShowsWidgetsState();
}

class _TvShowsWidgetsState extends State<TvShowsWidgets> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(loading);
  }

  void loading() async {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    if (currentScroll == maxScroll) {
      context.read<SearchBloc>().add(LoadMoreDataTvShowsEvent());
    }
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(loading)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<SearchBloc>(context);

        switch (state.requestSatutsTvShows) {
          case RequestSatuts.loading:
            return LoadingSearchWidget(opacity: widget.opacity);
          case RequestSatuts.loaded:
            return SizedBox(
              height: widget.media.height,
              child: RefreshIndicator(
                onRefresh: () async {
                  bloc.add(const GetTvShowsEvent());
                },
                child: GridView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(
                        vertical: widget.media.height * .02),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .6,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                    ),
                    itemCount: state.getMoreResults
                        ? state.tvShowsList.length
                        : state.tvShowsList.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => index >=
                            state.tvShowsList.length
                        ? Shimmer.fromColors(
                            baseColor: Colors.white24,
                            highlightColor: Colors.grey,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black38),
                              child: const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 1),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: widget.media.width,
                            // color: Colors.green,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: widget.media.width,
                                    // color: Colors.amber,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            color: ColorConstance.cDefaultColor,
                                            backgroundColor: ColorConstance
                                                .cDefaultColor
                                                .withOpacity(.05),
                                          ),
                                        ),
                                        imageUrl: ApiConstance.imageUrl(
                                          state.tvShowsList[index].posterPath!,
                                        ),
                                        fadeInCurve: Curves.bounceInOut,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Image.asset(
                                            IconConstance.iWarningIcon,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  state.tvShowsList[index].name?.toString() ??
                                      "",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: smallStyleSize.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  state.tvShowsList[index].overview!,
                                  maxLines: 1,
                                  style: smallTextStyleAuthScreens.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: const Color.fromARGB(
                                          255, 167, 167, 167)),
                                ),
                              ],
                            ),
                          )),
              ),
            );
          case RequestSatuts.empty:
            return const Center();
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
