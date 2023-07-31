// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:play/core/utils/app_constance/app_constance.dart';

import '../../../data/repository_pattern/remote_data/get_home_screen_data.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';
import 'package:play/data/models/collection_model.dart';
import 'package:play/data/models/movie_model.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc(this.getDataForHomeScreen) : super(const HomeScreenState()) {
    on<GetOnAirMovieEvent>(_getOnAirMovieEvent);
    on<GetSpecialMovieForUserEvent>(_getSpecialForUserEvent);
    on<GetPopluarMovieEvent>(_getPopluarMovieEvent);
    on<GetUpComingMovieEvent>(_getUpComingMovieEvent);
    on<GetCollectionsEvent>(_getCollectionsEvent);
    on<GetCartoonMovieEvent>(_getCartoonMovieEvent);

    on<GetCrimeMovieEvent>(_getCrimeMovieEvent);
  }

  final GetDataForHomeScreen getDataForHomeScreen;

  Future<FutureOr<void>> _getOnAirMovieEvent(
      GetOnAirMovieEvent event, Emitter<HomeScreenState> emit) async {
    final result = await getDataForHomeScreen.fetchAiringTodayMovie();

    result.fold((l) {
      emit(
        state.copyWith(
          errorMessage: "Airing Today",
          requestSatutsFirstPart: RequestSatuts.failure,
        ),
      );
    }, (listAiringTodayMovies) {
      if (listAiringTodayMovies.isEmpty) {
        emit(
          state.copyWith(
              airingTodayMovie: listAiringTodayMovies,
              requestSatuts: RequestSatuts.empty),
        );
      } else {
        final list = filiterListFromNullOpartion(listAiringTodayMovies);
        emit(
          state.copyWith(
            airingTodayMovie: list,
            requestSatutsAiringToday: RequestSatuts.loaded,
            requestSatuts: RequestSatuts.loaded,
          ),
        );
      }
      print("Success Get Airing Today Movies =>  $listAiringTodayMovies");
    });
  }

  Future<FutureOr<void>> _getSpecialForUserEvent(
      GetSpecialMovieForUserEvent event, Emitter<HomeScreenState> emit) async {
    final result = await getDataForHomeScreen.fetchSpecialForUserMovie();
    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsFirstPart: RequestSatuts.failure,
        ),
      );
    }, (listSpecialForUserMovies) {
      final list = filiterListFromNullOpartion(listSpecialForUserMovies);
      if (listSpecialForUserMovies.isEmpty) {
        emit(
          state.copyWith(
              specialForUserMovie: listSpecialForUserMovies,
              requestSatuts: RequestSatuts.empty),
        );
      } else {
        emit(
          state.copyWith(
              specialForUserMovie: list,
              requestSatutsForYou: RequestSatuts.loaded),
        );
      }

      print(
          "Success Get Special For User Movies =>  $listSpecialForUserMovies");
    });
  }

  Future<FutureOr<void>> _getPopluarMovieEvent(
      GetPopluarMovieEvent event, Emitter<HomeScreenState> emit) async {
    final result = await getDataForHomeScreen.fetchPopluarMovie();
    result.fold((l) {
      emit(
        state.copyWith(
          errorMessage: "Popluar Movie",
          requestSatutsFirstPart: RequestSatuts.failure,
        ),
      );
    }, (listPopularMovies) {
      if (listPopularMovies.isEmpty) {
        emit(
          state.copyWith(
            popularMovie: listPopularMovies,
            requestSatuts: RequestSatuts.empty,
          ),
        );
      } else {
        final list = filiterListFromNullOpartion(listPopularMovies);

        emit(
          state.copyWith(
            popularMovie: list,
            requestSatutsPopluar: RequestSatuts.loaded,
          ),
        );
      }

      print("Success Get Popular Movies Movies =>  $listPopularMovies");
    });
  }

  List<MovieModel> filiterListFromNullOpartion(
      List<MovieModel> listAiringTodayMovies) {
    return listAiringTodayMovies
        .where((movie) => movie.backdropPath != "null" && movie.overview != "")
        .map((movie) => movie)
        .toList();
  }

  Future<FutureOr<void>> _getCollectionsEvent(
      GetCollectionsEvent event, Emitter<HomeScreenState> emit) async {
    final result = await getDataForHomeScreen.fetchActionCollectionMovie();
    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsSecondPart: RequestSatuts.failure,
        ),
      );
    }, (r) {
      final filiterList = filiterCoversCollections(r);
      if (r.isNotEmpty) {
        emit(
          state.copyWith(
            actionMovie: filiterList,
          ),
        );
        add(GetCartoonMovieEvent());
      }
      print("Success Get Action Movies =>  $r");
    });
  }

  Future<FutureOr<void>> _getCartoonMovieEvent(
      GetCartoonMovieEvent event, Emitter<HomeScreenState> emit) async {
    final result = await getDataForHomeScreen.fetchCartoonCollectionMovie();
    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsSecondPart: RequestSatuts.failure,
        ),
      );
    }, (r) {
      final filiterList = filiterCoversCollections(r);

      if (r.isNotEmpty) {
        emit(
          state.copyWith(
            cartoonMovie: filiterList,
          ),
        );
        add(GetCrimeMovieEvent());
      }

      print("Success Get Cartoon Movies =>  $r");
    });
  }

  Future<FutureOr<void>> _getCrimeMovieEvent(
      GetCrimeMovieEvent event, Emitter<HomeScreenState> emit) async {
    final result = await getDataForHomeScreen.fetchCrimeCollectionMovie();
    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsSecondPart: RequestSatuts.failure,
        ),
      );
    }, (r) {
      final list = filiterCoversCollections(r);
      if (r.isNotEmpty) {
        emit(
          state.copyWith(
              crimMovie: list, requestSatutsTopRated: RequestSatuts.loaded),
        );
        print("Success Get crim Movies =>  $r");
      }
    });
  }

  List<CollectionModel> filiterCoversCollections(List<CollectionModel> r) {
    final list = r
        .where((movie) => movie.backdropPath != "null")
        .map((movie) => movie)
        .toList();

    return list;
  }

  Future<FutureOr<void>> _getUpComingMovieEvent(
      GetUpComingMovieEvent event, Emitter<HomeScreenState> emit) async {
    final result = await getDataForHomeScreen.fetchComingSoonMovie();
    result.fold((l) {
      emit(
        state.copyWith(
          errorMessage: "Up Coming Movie",
          requestSatutsSecondPart: RequestSatuts.failure,
        ),
      );
    }, (listcomingSoonMovie) {
      if (listcomingSoonMovie.isEmpty) {
        emit(
          state.copyWith(
            requestSatutsComingSoon: RequestSatuts.empty,
          ),
        );
      } else {
        print("Success Get coming Soon Movies =>  $listcomingSoonMovie");
        final filiterList = listcomingSoonMovie
            .where((movie) => movie.backdropPath != "null")
            .map((movie) => movie)
            .toList();

        emit(
          state.copyWith(
            comingSoonMovie: filiterList,
            requestSatutsComingSoon: RequestSatuts.loaded,
          ),
        );
      }
    });
  }
}
