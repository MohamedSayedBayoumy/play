// ignore_for_file: avoid_print

import 'dart:math';

import 'package:dio/dio.dart';

import '../../main.dart';

abstract class ApiConstance {
  static const baseUrl = "https://api.themoviedb.org/3/tv/";
  static const baseUrlCollection = "https://api.themoviedb.org/3/";
  static const apiKey = "a5b623339bde6edb69983e11e6e2d3a4";
  static const baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static final randomPage = Random().nextInt(17) + 1;

  static final randomPageAiringToday = Random().nextInt(7)+1;

  static final randomDay = Random().nextInt(13)+1;

  static Future<Response> dio(String url) => Dio().get(url);

  static int getRandomSeries() {
    final data = prefs.getString("InterstingMovie");
    final list = data!.replaceAll('{', '').replaceAll('}', '').split(',');
    var randomSeriesId = list[Random().nextInt(list.length)];
    int series = int.parse(randomSeriesId);
    print("Random Series Id => $randomSeriesId");

    return series;
  }

  static int getRandomSeriesForSearch() {
    final data = prefs.getString("ListOfUserSearch");
    final list = data!.replaceAll('{', '').replaceAll('}', '').split(',');
    var randomSeriesId = list[Random().nextInt(list.length)];
    int series = int.parse(randomSeriesId);
    print("Random Series Id => $randomSeriesId");

    return series;
  }

  static String imageUrl(String path) => "$baseImageUrl$path";
}
