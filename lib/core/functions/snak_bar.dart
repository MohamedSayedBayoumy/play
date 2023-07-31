// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../text_styles/text_style.dart';

snackBar(
  BuildContext context, {
  required String message,
  bool? isFailure = false,
  bool? isSuccess = false,
}) =>
    Flushbar(
      icon: Icon(
        isSuccess == true ? Icons.check_rounded : Icons.info_outline,
        color: isSuccess == true
            ? const Color.fromARGB(255, 63, 231, 69)
            : isFailure == true
                ? Colors.white
                : Colors.black,
      ),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      borderRadius: BorderRadius.circular(8),
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: isFailure == true
          ? const Color.fromARGB(255, 191, 16, 3)
          : Colors.white,
      isDismissible: false,
      duration: const Duration(seconds: 5),
      messageText: Text(message,
          style: defaultStyleSize.copyWith(
            fontSize: 15,
            color: isFailure == true ? Colors.white : Colors.black,
          )),
    ).show(context);
