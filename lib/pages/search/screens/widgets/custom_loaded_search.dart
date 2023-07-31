import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play/core/text_styles/text_style.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../data/models/search_home_model.dart';
import '../../controllers/search_bloc.dart';

class LoadedSearchWidget extends StatefulWidget {
  final List<SearchHomeModel>? listOfMoviesOfResults;
  final int count;
  final Future<void> Function() onRefresh;
  final SearchEvent? event;
  final bool? getData;
 const  LoadedSearchWidget(
      {this.listOfMoviesOfResults,
      required this.count,
      required this.event,
      super.key,
      required this.getData,
      required this.onRefresh});

  @override
  State<LoadedSearchWidget> createState() => _LoadedSearchWidgetState();
}

class _LoadedSearchWidgetState extends State<LoadedSearchWidget> {
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
      context.read<SearchBloc>().add(widget.event!);
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
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: GridView.builder(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(vertical: media.height * .02),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .6,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 2,
          ),
          itemCount: widget.getData! ? widget.count : widget.count + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) => index >=
                  widget.listOfMoviesOfResults!.length
              ? Shimmer.fromColors(
                  baseColor: Colors.white24,
                  highlightColor: Colors.grey,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38),
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 1),
                    ),
                  ),
                )
              : SizedBox(
                  width: media.width,
                  // color: Colors.green,

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
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstance.cDefaultColor,
                                  backgroundColor: ColorConstance.cDefaultColor
                                      .withOpacity(.05),
                                ),
                              ),
                              imageUrl: ApiConstance.imageUrl(
                                widget
                                    .listOfMoviesOfResults![index].posterPath!,
                              ),
                              fadeInCurve: Curves.bounceInOut,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Center(
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
                        widget.listOfMoviesOfResults![index].title
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
                        widget.listOfMoviesOfResults![index].overview!,
                        maxLines: 1,
                        style: smallTextStyleAuthScreens.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: const Color.fromARGB(255, 167, 167, 167)),
                      ),
                    ],
                  ),
                )),
    );
  }
}
