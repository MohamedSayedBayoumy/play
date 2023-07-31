// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:play/data/models/collection_model.dart';
import 'package:play/data/models/movie_model.dart';

import '../../../core/utils/app_constance/app_constance.dart';
import '../../../data/models/up_coming_model.dart';

class HomeScreenState extends Equatable {
  final RequestSatuts requestSatuts;

  final RequestSatuts requestSatutsForYou;
  final RequestSatuts requestSatutsPopluar;
  final RequestSatuts requestSatutsAiringToday;
  final RequestSatuts requestSatutsTopRated;
  final RequestSatuts requestSatutsComingSoon;
  final List<MovieModel> airingTodayMovie;
  final List<MovieModel> specialForUserMovie;
  final List<MovieModel> popularMovie;
  final List<MovieModel> topRatedMovie;
  final List<UpComingModel> comingSoonMovie;
  final List<CollectionModel> cartoonMovie;
  final List<CollectionModel> actionMovie;
  final List<CollectionModel> crimMovie;

  const HomeScreenState({
    this.cartoonMovie = const [],
    this.requestSatutsComingSoon = RequestSatuts.loading,
    this.actionMovie = const [],
    this.crimMovie = const [],
    this.airingTodayMovie = const [],
    this.comingSoonMovie = const [],
    this.topRatedMovie = const [],
    this.specialForUserMovie = const [],
    this.popularMovie = const [],
    this.requestSatuts = RequestSatuts.loading,
    this.requestSatutsAiringToday = RequestSatuts.loading,
    this.requestSatutsForYou = RequestSatuts.loading,
    this.requestSatutsTopRated = RequestSatuts.loading,
    this.requestSatutsPopluar = RequestSatuts.loading,
  });

  HomeScreenState copyWith(
          {String? errorMessage,
          List<String>? listOfCover,
          RequestSatuts? requestSatutsFirstPart,
          RequestSatuts? requestSatuts,
          RequestSatuts? requestSatutsForYou,
          RequestSatuts? requestSatutsPopluar,
          RequestSatuts? requestSatutsAiringToday,
          RequestSatuts? requestSatutsTopRated,
          RequestSatuts? requestSatutsSecondPart,
          RequestSatuts? requestSatutsComingSoon,
          List<String>? listOfCartoonCover,
          List<String>? listOfActionCover,
          List<String>? listOfCrimCover,
          List<CollectionModel>? cartoonMovie,
          List<CollectionModel>? actionMovie,
          List<CollectionModel>? comdyMovie,
          List<CollectionModel>? crimMovie,
          List<MovieModel>? specialForUserMovie,
          List<MovieModel>? topRatedMovie,
          List<MovieModel>? popularMovie,
          List<UpComingModel>? comingSoonMovie,
          List<MovieModel>? airingTodayMovie}) =>
      HomeScreenState(
          requestSatutsComingSoon:
              requestSatutsComingSoon ?? this.requestSatutsComingSoon,
          requestSatuts: requestSatuts ?? this.requestSatuts,
          actionMovie: actionMovie ?? this.actionMovie,
          cartoonMovie: cartoonMovie ?? this.cartoonMovie,
          crimMovie: crimMovie ?? this.crimMovie,
          comingSoonMovie: comingSoonMovie ?? this.comingSoonMovie,
          specialForUserMovie: specialForUserMovie ?? this.specialForUserMovie,
          topRatedMovie: topRatedMovie ?? this.topRatedMovie,
          airingTodayMovie: airingTodayMovie ?? this.airingTodayMovie,
          popularMovie: airingTodayMovie ?? this.popularMovie,
          requestSatutsAiringToday:
              requestSatutsAiringToday ?? this.requestSatutsAiringToday,
          requestSatutsForYou: requestSatutsForYou ?? this.requestSatutsForYou,
          requestSatutsPopluar:
              requestSatutsPopluar ?? this.requestSatutsPopluar,
          requestSatutsTopRated:
              requestSatutsTopRated ?? this.requestSatutsTopRated);
  @override
  List<Object> get props {
    return [
      requestSatutsComingSoon,
      requestSatuts,
      requestSatutsForYou,
      requestSatutsPopluar,
      requestSatutsAiringToday,
      requestSatutsTopRated,
      airingTodayMovie,
      specialForUserMovie,
      popularMovie,
      topRatedMovie,
      comingSoonMovie,
      cartoonMovie,
      actionMovie,
      crimMovie,
    ];
  }
}
