// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'movie_model.dart';

class OnBoradingModel extends Equatable {
  final List<String>? title;
  final List<String>? subTitle;
  final List<MovieModel>? images;
  const OnBoradingModel({this.title, this.subTitle, this.images});

  @override
  List<Object?> get props => [
        title,
        subTitle,
        images,
      ];
}
