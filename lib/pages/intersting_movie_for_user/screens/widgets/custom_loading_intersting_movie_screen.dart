import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../core/text_styles/text_style.dart';

class InterstingMovieLoadingStatuWidget extends StatelessWidget {
  const InterstingMovieLoadingStatuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Choose 3 or more shows that interest you",
          style: largeStyleSize.copyWith(
            fontSize: 35,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 4.5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
          ),
          itemCount: 12,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.white24,
              highlightColor: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38),
              ),
            );
          },
        ),
      ],
    );
  }
}
