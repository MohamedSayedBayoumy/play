import 'dart:ui';

import 'package:flutter/material.dart';

import '../text_styles/text_style.dart';
import '../utils/app_constance/color_constance.dart';
import '../widgets/custom_button.dart';

Future<void> showMyDialog(
  BuildContext context, {
  String? title,
  Widget? content,
  String? subTitle,
  String? textButton,
  bool? needButton = false,
  bool barrierDismissible = true,
  bool needBackgroundColor = true,
  EdgeInsetsGeometry? titlePadding,
  void Function()? onPressed,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: needBackgroundColor == true
              ? ColorConstance.cbackGroundColor
              : Colors.transparent,
          titlePadding: titlePadding,
          title: Text(
            title?.toString() ?? "",
            style: defaultStyleSize.copyWith(
                color: ColorConstance.cDefaultColor,
                fontWeight: FontWeight.w600),
          ),
          content: content ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Text(subTitle!,
                      textAlign: TextAlign.center,
                      style: defaultStyleSize.copyWith(
                          fontSize: 15, color: Theme.of(context).primaryColor)),
                  const SizedBox(height: 40),
                  needButton == true
                      ? customButton(
                          width: MediaQuery.of(context).size.width * .54,
                          height: MediaQuery.of(context).size.height * .04,
                          borderRadius: 8,
                          onPressed: onPressed,
                          text: textButton ?? "Reload",
                        )
                      : const SizedBox(),
                ],
              ),
        ),
      );
    },
  );
}
