// ignore_for_file: deprecated_member_use, avoid_print
 

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:play/core/utils/api_consatance.dart';

import '../../../core/errors/handle_errors.dart';
import '../../models/movie_model.dart';

abstract class GetImagesOnBorading {
  Future<Either<HandleInternetConnectionError, List<MovieModel>>>
      getImagesOnBorading(int randomPage);
}

class FetchImagesOnBorading implements GetImagesOnBorading {
  @override
  Future<Either<HandleInternetConnectionError, List<MovieModel>>>
      getImagesOnBorading(int randomPage) async {
    try {
      final response = await Dio().get(
          "${ApiConstance.baseUrl}airing_today?api_key=${ApiConstance.apiKey}&language=en&page=$randomPage");

      return Right(List<MovieModel>.from(
              response.data["results"].map((e) => MovieModel.fromJson(e)))
          .getRange(0, 3)
          .toList());
    } on DioExceptionType catch (e) {
      print("Dio Error Type : $e");
      return left(HandleInternetConnectionError.fromDioExceptionType(e));
    }
  }
}
