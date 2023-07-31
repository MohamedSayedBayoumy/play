import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../text_styles/text_style.dart';

// ignore: camel_case_types
class customButton extends StatefulWidget {
  final void Function()? onPressed;
  final String? text;
  final Widget? child;
  final double? elevation;
  final double? width;
  final double? padding;
  final double? borderRadius;
  final double? height;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? media;
  final BuildContext? context;
  const customButton({
    Key? key,
    this.onPressed,
    this.text,
    this.borderRadius,
    this.child,
    this.elevation,
    this.width,
    this.padding,
    this.height,
    this.fontSize,
    this.backgroundColor,
    this.textColor,
    this.media,
    this.context,
  }) : super(key: key);

  @override
  State<customButton> createState() => _customButtonState();
}

// ignore: camel_case_types
class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SizedBox(
        width: widget.width,
        height: widget.height ?? media.height * .06,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgroundColor,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.padding ??
                      MediaQuery.of(context).size.width * .07),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 15))),
          child: widget.child ??
              Text(
                widget.text!.tr,
                style: buttonTextStyleSize.copyWith(color: Colors.white),
              ),
        ));
  }
}
