import 'package:flutter/material.dart';

import '../text_styles/text_style.dart';
import '../utils/app_constance/icon_constance.dart';

class FailureWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  const FailureWidget({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: EdgeInsets.only(top: media.height / 2.2),
        children: [
          Column(
            children: [
              Image.asset(
                IconConstance.iWarningIcon,
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Check your Internet Connection , Refresh to Reload",
                  textAlign: TextAlign.center,
                  style: defaultStyleSize.copyWith(
                      color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
