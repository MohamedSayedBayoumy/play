// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

import '../core/functions/alert_dialog.dart';

import '../core/text_styles/text_style.dart';
import '../core/utils/app_constance/icon_constance.dart';
import '../core/widgets/custom_navigation.dart';
import '../data/models/onborading_model.dart';
import '../data/repository_pattern/remote_data/get_images_onborading.dart';
import 'on_boarding/on_borading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  GetImagesOnBorading fetchImagesOnBorading = FetchImagesOnBorading();

  OnBoradingModel? onBoradingModel = const OnBoradingModel();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: 'P',
                style: largeStyleSize.copyWith(
                    color: Theme.of(context).primaryColor),
                children: const <TextSpan>[
                  TextSpan(
                    text: 'L',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            FadeTransition(
              opacity: animation,
              child: Image.asset(
                IconConstance.iPlayIcon,
                width: 30,
              ),
            ),
            Text(
              "Y",
              style: largeStyleSize.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    final response =
        await fetchImagesOnBorading.getImagesOnBorading(Random().nextInt(15));
    response.fold((l) {
      showMyDialog(context, title: "Notice", subTitle: l.message.toString(),
          onPressed: () {
        Navigator.pop(context);
        loadData();
      });
    }, (r) {
      onBoradingModel = OnBoradingModel(
        images: r,
        title: const [
          "Watch on\nany device",
          "Choose,\nseclect, watch",
          "Download\nand go",
        ],
        subTitle: const [
          "Stream on your phone, tablet,\nlaptop and TV without more",
          "Smart filiters will help you to find the best one\namong various characteristics movies",
          "Save your data, watch offline\n on a plane, train, or car",
        ],
      );
    });
    if (onBoradingModel!.images != null) {
      Future.delayed(
        const Duration(seconds: 4),
        () {
          AnimationRoute.fadeRoute(context,
              pageRoute: OnBoradingScreen(
                onBoradingModels: onBoradingModel!,
              ));
        },
      );
    } else {
      print("ERROR : onBoradingModel!.images = null");
    }
  }
}
