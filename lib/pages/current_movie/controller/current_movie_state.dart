// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:play/data/models/recommendation_model.dart';

import '../../../core/utils/app_constance/app_constance.dart';
import '../../../data/models/images_movie_model.dart';
import '../../../data/models/type_movie_model.dart';
import '../../../data/models/youtube_id_model.dart';

class CurrentMovieState extends Equatable {
  final RequestSatuts requestSatuts;
  final List<YoutubeIdModel> youtubeIdModel;
  final List<TypeMovieModel> typeMovieModel;
  final List<RecommendationModel> recommendationList;
  final ImagesMovieModel? imagesMovieModel;

  const CurrentMovieState({
    this.requestSatuts = RequestSatuts.loading,
    this.youtubeIdModel = const [],
    this.recommendationList = const [],
    this.typeMovieModel = const [],
    this.imagesMovieModel,
  });
  CurrentMovieState copyWith(
      {RequestSatuts? requestSatuts,
      List<YoutubeIdModel>? youtubeIdModel,
      List<TypeMovieModel>? typeMovieModel,
      List<RecommendationModel>? recommendationList,
      ImagesMovieModel? imagesMovieModel}) {
    return CurrentMovieState(
        recommendationList: recommendationList ?? this.recommendationList,
        imagesMovieModel: imagesMovieModel ?? this.imagesMovieModel,
        requestSatuts: requestSatuts ?? this.requestSatuts,
        youtubeIdModel: youtubeIdModel ?? this.youtubeIdModel,
        typeMovieModel: typeMovieModel ?? this.typeMovieModel);
  }

  @override
  List<Object> get props => [requestSatuts, youtubeIdModel, typeMovieModel];
}
