// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison, avoid_print
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:play/core/text_styles/text_style.dart';
import 'package:play/data/models/collection_model.dart';

import '../../../../core/utils/api_consatance.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';

class CategoriesWidegt extends StatelessWidget {
  final List<CollectionModel> movie;
  final String collectionTitle;
  final Size media;

  const CategoriesWidegt({
    Key? key,
    required this.movie,
    required this.collectionTitle,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(movie[Random().nextInt(movie.length)].backdropPath!);
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => SizedBox(
                width: media.width,
                height: media.height * .5,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorConstance.cDefaultColor,
                    backgroundColor:
                        ColorConstance.cDefaultColor.withOpacity(.05),
                  ),
                ),
              ),
              imageUrl: ApiConstance.imageUrl(
                movie[Random().nextInt(movie.length)].backdropPath!,
              ),
              fadeInCurve: Curves.bounceInOut,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Center(
                child: Image.asset(
                  IconConstance.iWarningIcon,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
            child: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 20),
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(15)),
          child: Text(
            collectionTitle,
            style: largeStyleSize.copyWith(color: Colors.white, fontSize: 30),
          ),
        ))
      ],
    );
  }
}
