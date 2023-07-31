// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:play/data/models/recommendation_model.dart';

import '../../../core/errors/handle_errors.dart';
import '../../../core/utils/api_consatance.dart';
import '../../models/images_movie_model.dart';
import '../../models/type_movie_model.dart';
import '../../models/youtube_id_model.dart';

abstract class GetCurrentMovieDetails {
  Future<Either<HandleFailure, List<YoutubeIdModel>>> getCurrentMovieVedio(
      {required int movieId});
  Future<Either<HandleFailure, ImagesMovieModel>> getCurrentMovieImages(
      {required int movieId});

  Future<Either<HandleFailure, List<TypeMovieModel>>> getCurrentMovieType(
      {required int movieId});

  Future<Either<HandleFailure, List<RecommendationModel>>>
      getRecommendationMovieType({required int movieId});
}

class FetchCurrentMovie implements GetCurrentMovieDetails {
  @override
  Future<Either<HandleFailure, List<YoutubeIdModel>>> getCurrentMovieVedio(
      {required int movieId}) async {
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}/$movieId/videos?api_key=${ApiConstance.apiKey}");

      return Right(List<YoutubeIdModel>.from(
          response.data["results"].map((e) => YoutubeIdModel.fromJson(e))));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} ,videos  ");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<TypeMovieModel>>> getCurrentMovieType(
      {required int movieId}) async {
    print(movieId);
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}/$movieId/content_ratings?api_key=${ApiConstance.apiKey}");

      if (response.data["results"] == null) {
        return const Right([]);
      } else {
        return Right(List<TypeMovieModel>.from(
            response.data["results"].map((e) => TypeMovieModel.fromJson(e))));
      }
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} ,content_ratings");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, ImagesMovieModel>> getCurrentMovieImages(
      {required int movieId}) async {
    print(movieId);
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}/$movieId/images?api_key=${ApiConstance.apiKey}");

      return Right(ImagesMovieModel.fromJson(response.data));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} , images ");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<RecommendationModel>>>
      getRecommendationMovieType({required int movieId}) async {
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}/$movieId/recommendations?api_key=${ApiConstance.apiKey}");

      return Right(List<RecommendationModel>.from(response.data["results"]
          .map((e) => RecommendationModel.fromJson(e))));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} , recommendations ");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }
}
