import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  final Size media;
  final double? width;
  const CustomContainerWidget({super.key, required this.media, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? media.width,
      height: media.height * .03,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(5),
        ),
      ),
    );
  }
}
