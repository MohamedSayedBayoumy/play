// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/text_styles/text_style.dart';
import '../../../core/utils/api_consatance.dart';
import '../../../core/utils/app_constance/app_constance.dart';
import '../../../core/utils/app_constance/color_constance.dart';
import '../../../core/utils/app_constance/icon_constance.dart';
import '../../../core/widgets/custom_failure.dart';
import '../../../core/widgets/cutom_text_field/custom_text_filed.dart';
import '../../../main.dart';
import '../controllers/search_bloc.dart';
import '../controllers/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final scrollController = ScrollController();

  int nextPage = 2;
  String textSearch = " ";
  @override
  void initState() {
    super.initState();
    scrollController.addListener(loading);
  }

  void loading() async {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    if (currentScroll == maxScroll) {
      context
          .read<SearchBloc>()
          .add(SearchMoviesEvent(quary: textSearch, page: nextPage++));
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
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: media.height * .05,
            left: media.width * .03,
            right: media.width * .03),
        child: Column(
          children: [
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<SearchBloc>(context);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomTextField(
                    prefixIcon: Icons.search,
                    controller: state.searchController,
                    onChange: (value) {
                      textSearch = value!;
                      bloc.add(
                        SearchMoviesEvent(quary: value.toString(), page: 1),
                      );
                      return value;
                    },
                    hinText: "Search",
                    maxLength: 1,
                  ),
                );
              },
            ),
            Expanded(
              // height: media.height,
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  switch (state.requestSatutsSearchLoading) {
                    case RequestSatuts.loading:
                      if (state.searchController.text.isEmpty &&
                          prefs.getString("ListOfUserSearch") == null &&
                          state.collectionSearchList.isEmpty) {
                        return Center(
                            child: Text(
                          "Strat Search",
                          textAlign: TextAlign.center,
                          style: defaultStyleSize.copyWith(
                              color: Theme.of(context).primaryColor),
                        ));
                      }
                      if (prefs.getString("ListOfUserSearch") != null &&
                          state.searchController.text.isEmpty) {
                        return Container(
                          width: media.width,
                          height: media.height,
                          color: Colors.amber,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {},
                          ),
                        );
                      }
                      if (state.collectionSearchList.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: media.height * .4,
                              child: GridView.builder(
                                  controller: scrollController,
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.symmetric(
                                      vertical: media.height * .02),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: .6,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => SizedBox(
                                        width: media.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                width: media.width,
                                                // color: Colors.amber,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: ColorConstance
                                                            .cDefaultColor,
                                                        backgroundColor:
                                                            ColorConstance
                                                                .cDefaultColor
                                                                .withOpacity(
                                                                    .05),
                                                      ),
                                                    ),
                                                    imageUrl:
                                                        ApiConstance.imageUrl(
                                                      state
                                                          .collectionSearchList[
                                                              index]
                                                          .posterPath!,
                                                    ),
                                                    fadeInCurve:
                                                        Curves.bounceInOut,
                                                    fit: BoxFit.cover,
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
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              state.collectionSearchList[index]
                                                      .originalName
                                                      ?.toString() ??
                                                  "",
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: smallStyleSize.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              state.collectionSearchList[index]
                                                  .overview!,
                                              maxLines: 1,
                                              style: smallTextStyleAuthScreens
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 10,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              167,
                                                              167,
                                                              167)),
                                            ),
                                          ],
                                        ),
                                      )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const CircularProgressIndicator(
                              color: ColorConstance.cDefaultColor,
                            ),
                          ],
                        );
                      } else {
                        return const Center();
                      }

                    case RequestSatuts.loaded:
                      return GridView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding:
                            EdgeInsets.symmetric(vertical: media.height * .02),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .6,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          crossAxisCount: 2,
                        ),
                        itemCount: state.getMoreResults
                            ? state.collectionSearchList.length
                            : state.collectionSearchList.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index >= state.collectionSearchList.length) {
                            return Shimmer.fromColors(
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
                            );
                          } else {
                            return SizedBox(
                              width: media.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: media.width,
                                      // color: Colors.amber,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                              color:
                                                  ColorConstance.cDefaultColor,
                                              backgroundColor: ColorConstance
                                                  .cDefaultColor
                                                  .withOpacity(.05),
                                            ),
                                          ),
                                          imageUrl: ApiConstance.imageUrl(
                                            state.collectionSearchList[index]
                                                .posterPath!,
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
                                    state.collectionSearchList[index].name
                                            ?.toString() ??
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
                                    state.collectionSearchList[index].overview!,
                                    maxLines: 1,
                                    style: smallTextStyleAuthScreens.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: const Color.fromARGB(
                                            255, 167, 167, 167)),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      );

                    case RequestSatuts.empty:
                      return Center(
                          child: Text(
                        state.message,
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
          ],
        ),
      ),
    );
  }
}
