import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/text_styles/text_style.dart';
import '../../../core/utils/api_consatance.dart';
import '../../../core/utils/app_constance/color_constance.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_navigation.dart';
import '../../../data/models/onborading_model.dart';
 
import '../../core/utils/app_constance/icon_constance.dart';
import '../login_screens/screens/login_screen.dart';
 
class OnBoradingScreen extends StatefulWidget {
  final OnBoradingModel onBoradingModels;
  const OnBoradingScreen({required this.onBoradingModels, super.key});

  @override
  State<OnBoradingScreen> createState() => _OnBoradingScreenState();
}

class _OnBoradingScreenState extends State<OnBoradingScreen> {
  PageController pageController = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
        allowImplicitScrolling: true,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (index) {
          currentPage = index;
          setState(() {});
        },
        itemCount: widget.onBoradingModels.images!.length,
        itemBuilder: (context, index) => Stack(
          children: [
            Positioned.fill(
              child: ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    ColorConstance.cbackGroundColor,
                    ColorConstance.cbackGroundColor,
                    Colors.transparent,
                  ],
                  stops: [0, 0.3, .01, 5],
                ).createShader(
                  Rect.fromLTRB(
                      media.height * .03, 0, bounds.width * .09, bounds.height),
                ),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      SizedBox(
                    width: media.width,
                    height: media.height * .65,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorConstance.cDefaultColor,
                        backgroundColor:
                            ColorConstance.cDefaultColor.withOpacity(.05),
                      ),
                    ),
                  ),
                  imageUrl: ApiConstance.imageUrl(
                    widget.onBoradingModels.images![index].posterPath!,
                  ),
                  fadeInCurve: Curves.bounceInOut,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          IconConstance.iWarningIcon,
                          height: 50,
                        ),
                        Text(
                          "Check your Internet Connection",
                          style: defaultStyleSize.copyWith(
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                // color: Colors.amber,
                height: media.height * .6,
                width: media.width,
                padding: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        widget.onBoradingModels.title![index],
                        style: largeStyleSize.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        widget.onBoradingModels.subTitle![index],
                        style: smallStyleSize.copyWith(
                          color: const Color.fromARGB(255, 205, 205, 205),
                        ),
                      ),
                      const SizedBox(height: 55),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: widget.onBoradingModels.images!.length,
                        effect: ExpandingDotsEffect(
                          spacing: 8.0,
                          dotHeight: 5.0,
                          dotWidth: 15.0,
                          expansionFactor: 3.0,
                          dotColor: Colors.black54,
                          activeDotColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 50),
                      customButton(
                        text: "Next",
                        width: media.width,
                        onPressed: () {
                          if (currentPage == 2) {
                            AnimationRoute.slideRoute(
                              context,
                              pageRoute: const LoginScreen(),
                              rigthToLeft: true,
                            );
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
