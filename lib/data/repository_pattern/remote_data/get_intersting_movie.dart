// ignore_for_file: avoid_print


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/handle_errors.dart';
import '../../../core/utils/api_consatance.dart';
import '../../models/intersting_model.dart';

abstract class GetIntrestingMovie {
  Future<Either<HandleFailure, AllMovieModel>> getIntrestingMovie();
}

class FetchIntrestingMovie implements GetIntrestingMovie {
  @override
  Future<Either<HandleFailure, AllMovieModel>> getIntrestingMovie() async {
    try {
      print("Random Page For Intresting Movie ()=> ${ApiConstance.randomPage}");
      final response = await Dio().get(
          "https://api.themoviedb.org/3/tv/top_rated?api_key=${ApiConstance.apiKey}&page=${ApiConstance.randomPage}");

      return Right(AllMovieModel.fromJson(response.data));
    } on DioException catch (e) {
      print("ERROR : ${e.toString()}");
      return left(HandleInternetConnectionError.fromDioExceptionType(e.type));
    }
  }
}
