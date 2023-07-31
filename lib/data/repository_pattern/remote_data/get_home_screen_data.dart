// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:play/data/models/collection_model.dart';

import '../../../core/errors/handle_errors.dart';
import '../../../core/utils/api_consatance.dart';

import '../../models/movie_model.dart';
import '../../models/up_coming_model.dart';

abstract class GetDataForHomeScreen {
  Future<Either<HandleFailure, List<MovieModel>>> fetchAiringTodayMovie();
  Future<Either<HandleFailure, List<MovieModel>>> fetchSpecialForUserMovie();
  Future<Either<HandleFailure, List<MovieModel>>> fetchPopluarMovie();
  Future<Either<HandleFailure, List<UpComingModel>>> fetchComingSoonMovie();
  Future<Either<HandleFailure, List<CollectionModel>>>
      fetchCartoonCollectionMovie();
  Future<Either<HandleFailure, List<CollectionModel>>>
      fetchActionCollectionMovie();
  Future<Either<HandleFailure, List<CollectionModel>>>
      fetchCrimeCollectionMovie();
}

class FetchMovieData implements GetDataForHomeScreen {
  @override
  Future<Either<HandleFailure, List<MovieModel>>>
      fetchAiringTodayMovie() async {
    try {
      print("Random Number is ()=> ${ApiConstance.randomPageAiringToday}");
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}airing_today?api_key=${ApiConstance.apiKey}&language=en&page=7");

      return Right(
        List<MovieModel>.from(
            response.data["results"].map((e) => MovieModel.fromJson(e))),
      );
    } on DioException catch (e) {
      print("Dio Error Type : $e , fetchAiringTodayMovie ");

      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<MovieModel>>> fetchPopluarMovie() async {
    try {
      print("Random Number is ()=> ${ApiConstance.randomPage}");

      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}/popular?api_key=${ApiConstance.apiKey}&language=en&page=${ApiConstance.randomPage}");

      return Right(List<MovieModel>.from(
              response.data["results"].map((e) => MovieModel.fromJson(e)))
          .getRange(0, 10)
          .toList());
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} ,fetchPopluarMovie  ");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<MovieModel>>>
      fetchSpecialForUserMovie() async {
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}${ApiConstance.getRandomSeries()}/similar?api_key=${ApiConstance.apiKey}&page=${ApiConstance.randomPage}");

      return Right(
        List<MovieModel>.from(
            response.data["results"].map((e) => MovieModel.fromJson(e))),
      );
    } on DioException catch (e) {
      print("Dio Error Type : $e ,fetchSpecialForUserMovie ");

      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

 
  @override
  Future<Either<HandleFailure, List<UpComingModel>>>
      fetchComingSoonMovie() async {
    try {
      final response = await ApiConstance.dio(
          "https://api.themoviedb.org/3/movie/upcoming?api_key=${ApiConstance.apiKey}&language=en&page=${ApiConstance.randomPage}");

      return Right(List<UpComingModel>.from(
          response.data["results"].map((e) => UpComingModel.fromJson(e))));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} , fetchComingSoonMovie");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<CollectionModel>>>
      fetchActionCollectionMovie() async {
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrlCollection}search/collection?api_key=${ApiConstance.apiKey}&query=Action&page=1");

      return Right(List<CollectionModel>.from(
          response.data["results"].map((e) => CollectionModel.fromJson(e))));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} , fetchActionCollectionMovie");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<CollectionModel>>>
      fetchCartoonCollectionMovie() async {
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrlCollection}search/collection?api_key=${ApiConstance.apiKey}&page=1&query=Cartoon");

      return Right(List<CollectionModel>.from(
          response.data["results"].map((e) => CollectionModel.fromJson(e))));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} , fetchCartoonCollectionMovie");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<CollectionModel>>>
      fetchCrimeCollectionMovie() async {
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrlCollection}search/collection?api_key=${ApiConstance.apiKey}&page=1&query=Crime");

      return Right(List<CollectionModel>.from(response.data["results"].map(
        (e) => CollectionModel.fromJson(e),
      )));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()} , fetchCrimeCollectionMovie");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }
}
