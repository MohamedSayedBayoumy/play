import 'package:flutter/material.dart';

import '../../../../core/utils/app_constance/icon_constance.dart';

class LoadingSearchWidget extends StatelessWidget {
  final Animation<double> opacity;
  const LoadingSearchWidget({required this.opacity, super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: opacity,
        child: Image.asset(
          IconConstance.iPlayIcon,
          width: 50,
        ),
      ),
    );
  }
}
