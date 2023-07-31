import 'package:flutter/material.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';

class LoadingStateCurrnetMovie extends StatefulWidget {
  const LoadingStateCurrnetMovie({super.key});

  @override
  State<LoadingStateCurrnetMovie> createState() =>
      _LoadingStateCurrnetMovieState();
}

class _LoadingStateCurrnetMovieState extends State<LoadingStateCurrnetMovie>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FadeTransition(
      opacity: animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'P',
              style: defaultStyleSize.copyWith(
                  color: Colors.white30, fontSize: 30),
              children: <TextSpan>[
                TextSpan(
                  text: 'L',
                  style: defaultStyleSize.copyWith(
                      fontSize: 30, color: Colors.white30),
                ),
              ],
            ),
          ),
          Image.asset(
            IconConstance.iPlayIcon,
            width: 20,
            color: ColorConstance.cDefaultColor,
          ),
          Text(
            "Y",
            style: defaultStyleSize.copyWith(
              fontSize: 30,
              color: Colors.white30,
            ),
          ),
        ],
      ),
    ));
  }
}
