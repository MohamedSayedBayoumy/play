// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_get_it.dart';
import '../../../core/text_styles/text_style.dart';
import '../../../core/utils/app_constance/color_constance.dart';
import '../../../core/widgets/custom_navigation.dart';
import '../../../core/widgets/cutom_text_field/custom_text_filed.dart';
import '../controllers/search_bloc.dart';
import 'search_screen.dart';
import 'widgets/custom_all_shows.dart';
import 'widgets/custom_movies.dart';
import 'widgets/custom_tv_shows.dart';

class SearchHomeScreen extends StatefulWidget {
  const SearchHomeScreen({super.key});

  @override
  State<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends State<SearchHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: media.height * .05,
        ),
        child: DefaultTabController(
          length: 4,
          child: BlocProvider(
            create: (context) => sl<SearchBloc>()
              ..add(const GetAllShowEvent())
              ..add(const GetMoviesEvent())
              ..add(const GetTvShowsEvent()),
            child: RefreshIndicator(
              onRefresh: () async {},
              child: Column(
                children: [
                  CustomTextField(
                    onTap: () {
                      AnimationRoute.slideRoute(context,
                          pageRoute: BlocProvider(
                            create: (context) => sl<SearchBloc>(),
                            child: const SearchScreen(),
                          ));
                    },
                    height: media.height * .02,
                    hinText: "Search",
                    prefixIcon: Icons.search,
                    maxLength: 1,
                    minLength: 1,
                    controller: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    flex: 2,
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: ColorConstance.cDefaultColor,
                      unselectedLabelColor: Colors.white38,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      splashBorderRadius: BorderRadius.circular(20),
                      labelStyle: defaultStyleSize,
                      tabs: const [
                        Tab(text: "All Shows"),
                        Tab(text: "Movies"),
                        Tab(text: "TV shows"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 25,
                    child: SizedBox(
                      width: media.width,
                      height: media.height,
                      child: TabBarView(
                        children: <Widget>[
                          AllShowsWidget(opacity: animation, media: media),
                          MoviesWidget(opacity: animation, media: media),
                          TvShowsWidgets(opacity: animation, media: media),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
