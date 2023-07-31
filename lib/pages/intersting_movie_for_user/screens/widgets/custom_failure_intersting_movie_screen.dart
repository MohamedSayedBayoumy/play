import 'package:flutter/material.dart';

import '../../../../core/text_styles/text_style.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';

class InterstingMovieFailureStatueWidget extends StatelessWidget {
  const InterstingMovieFailureStatueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          "Choose 3 or more shows that interest you",
          style: largeStyleSize.copyWith(
            fontSize: 35,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: media.height * .34),
        Image.asset(
          IconConstance.iWarningIcon,
          height: 80,
        ),
        Text(
          "Check your Internet Connection , Refresh to Reload",
          textAlign: TextAlign.center,
          style:
              defaultStyleSize.copyWith(color: Theme.of(context).primaryColor),
        )
      ],
    );
  }
}
