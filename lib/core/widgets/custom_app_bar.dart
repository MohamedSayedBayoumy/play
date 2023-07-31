import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../text_styles/text_style.dart';

class CustomeAppBar extends StatelessWidget {
  final String title;
  const CustomeAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return SizedBox(
      width: media.width,
      height: media.height * .07,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        Text(
          title.toString().tr,
          style: defaultStyleSize,
        ),
      ]),
    );
  }
}
