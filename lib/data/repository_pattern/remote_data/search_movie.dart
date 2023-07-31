// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:play/data/models/search_home_model.dart';

import '../../../core/errors/handle_errors.dart';
import '../../../core/utils/api_consatance.dart';
import '../../models/search_model.dart';

abstract class GetMoviesBySearch {
  Future<Either<HandleFailure, List<SearchModel>>> fetchMovieBySearch(
      {required String quary, String? searchAbout, required int? page});

  Future<Either<HandleFailure, List<SearchHomeModel>>> fetchAllShowsForSearch(
      {required int randomPage});
  Future<Either<HandleFailure, List<SearchHomeModel>>> fetchForYouForSearch();
  Future<Either<HandleFailure, List<SearchModel>>> fetchTvShowsForSearch(
      {required int randomPage});
  Future<Either<HandleFailure, List<SearchHomeModel>>> fetchMovieForSearch(
      {required int randomPage});
}

class FetchMoviesBySearch implements GetMoviesBySearch {
  @override
  Future<Either<HandleFailure, List<SearchModel>>> fetchMovieBySearch(
      {required String quary, String? searchAbout, required int? page}) async {
    try {
      print("Next page () => $page");
      final response = await ApiConstance.dio(
          "https://api.themoviedb.org/3/search/${searchAbout?.toString() ?? "tv"}?api_key=${ApiConstance.apiKey}&language=en&page=$page&query=$quary");

      if (response.data["results"] == null) {
        return Right(
          List<SearchModel>.from(
              response.data["results"].map((e) => SearchModel.fromJson(e))),
        );
      } else {
        return Right(List<SearchModel>.from(
            response.data["results"].map((e) => SearchModel.fromJson(e))));
      }
    } on DioException catch (e) {
      print("Dio Error Type : $e , fetchMovieBySearch ");

      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<SearchHomeModel>>> fetchAllShowsForSearch(
      {required int randomPage}) async {
    try {
      final response = await ApiConstance.dio(
          "https://api.themoviedb.org/3/trending/all/day?api_key=${ApiConstance.apiKey}&page=$randomPage");

      return Right(
        List<SearchHomeModel>.from(response.data["results"]
            .map((e) => SearchHomeModel.fromJson(e))) ,
      );
    } on DioException catch (e) {
      print("Dio Error Type : $e , fetchAllShowsForSearch ");

      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<SearchHomeModel>>> fetchMovieForSearch(
      {required int randomPage}) async {
    try {
      final response = await ApiConstance.dio(
          "https://api.themoviedb.org/3/trending/movie/day?api_key=${ApiConstance.apiKey}&language=en&page=$randomPage");

      return Right(
        List<SearchHomeModel>.from(response.data["results"]
            .map((e) => SearchHomeModel.fromJson(e))) ,
      );
    } on DioException catch (e) {
      print("Dio Error Type : $e , fetchMovieForSearch ");

      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<SearchModel>>> fetchTvShowsForSearch(
      {required int randomPage}) async {
    try {
      final response = await ApiConstance.dio(
          "https://api.themoviedb.org/3/trending/tv/day?api_key=${ApiConstance.apiKey}&language=en&page=$randomPage");

      return Right(
        List<SearchModel>.from(
                response.data["results"].map((e) => SearchModel.fromJson(e)))
            .getRange(0, 16)
            .toList(),
      );
    } on DioException catch (e) {
      print("Dio Error Type : $e , fetchTvShowsForSearch ");

      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }

  @override
  Future<Either<HandleFailure, List<SearchHomeModel>>>
      fetchForYouForSearch() async {
    try {
      final response = await ApiConstance.dio(
          "${ApiConstance.baseUrl}${ApiConstance.getRandomSeriesForSearch()}/recommendations?api_key=${ApiConstance.apiKey}&language=en&page=${ApiConstance.randomPage}");

      return Right(
        List<SearchHomeModel>.from(response.data["results"]
            .map((e) => SearchHomeModel.fromJson(e))) ,
      );
    } on DioException catch (e) {
      print("Dio Error Type : $e , fetchTvShowsForSearch ");

      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }
}
