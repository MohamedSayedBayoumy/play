// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:play/data/models/search_home_model.dart';
import '../../../core/utils/app_constance/app_constance.dart';
import '../../../data/repository_pattern/remote_data/search_movie.dart';
import '../../../main.dart';
import 'search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.getMoviesBySearch)
      : super(SearchState(searchController: TextEditingController())) {
    on<SearchMoviesEvent>(_searchMoviesEvent);

    on<GetForYouEvent>(_getForYouEvent);
    on<GetAllShowEvent>(_getAllShowEvent);
    on<LoadMoreDataAllShowsEvent>(_loadMoreDataAllShowsEvent);
    on<GetMoviesEvent>(_getMoviesEvent);
    on<LoadMoreDataMoviesEvent>(_loadMoreDataMoviesEvent);
    on<GetTvShowsEvent>(_getTvShowsEvent);
    on<LoadMoreDataTvShowsEvent>(_getLoadMoreDataTvShowsEvent);
  }

  final GetMoviesBySearch getMoviesBySearch;

  Future<FutureOr<void>> _searchMoviesEvent(
      SearchMoviesEvent event, Emitter<SearchState> emit) async {
    if (event.quary.isEmpty) {
      emit(
        state.copyWith(
          requestSatutsSearchLoading: RequestSatuts.loading,
          collectionSearchList: [],
        ),
      );
    } else {
      event.page == 1
          ? emit(
              state.copyWith(
                requestSatutsSearchLoading: RequestSatuts.loading,
              ),
            )
          : null;

      final result = await getMoviesBySearch.fetchMovieBySearch(
          quary: event.quary, page: event.page);

      result.fold((l) {
        emit(
          state.copyWith(
            requestSatutsSearchLoading: RequestSatuts.failure,
            searchController: state.searchController,
          ),
        );
      }, (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              requestSatutsSearchLoading: RequestSatuts.empty,
              message: "Not Found Results",
              collectionSearchList: [],
              searchController: state.searchController,
            ),
          );
        } else if (event.page == 1) {
          emit(state.copyWith(
            requestSatutsSearchLoading: RequestSatuts.loaded,
            collectionSearchList: r,
          ));
        } else {
          print(
              "List Length is Before ()=> ${state.collectionSearchList.length}");

          print(
              "Quary is ()=> search About :${event.quary} in page : ${event.page}");
          emit(
            state.copyWith(
              requestSatutsSearchLoading: RequestSatuts.loaded,
              getMoreResults: false,
              collectionSearchList: List.of(state.collectionSearchList)
                ..addAll(r),
            ),
          );
          print(
              "List Length is After ()=> ${state.collectionSearchList.length}");
          print(
              "List Length is After ()=> ${state.collectionSearchList[0].name}");
        }
      });
    }
  }

  Future<FutureOr<void>> _getForYouEvent(
      GetForYouEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        requestSatutsForYou: RequestSatuts.loading,
      ),
    );
    if (prefs.getString("ListOfUserSearch") == null ||
        prefs.getString("ListOfUserSearch")!.isEmpty) {
      emit(
        state.copyWith(
          requestSatutsForYou: RequestSatuts.empty,
        ),
      );
    } else {
      final result = await getMoviesBySearch.fetchForYouForSearch();

      result.fold((l) {
        emit(
          state.copyWith(
            requestSatutsAllShows: RequestSatuts.failure,
          ),
        );
      }, (r) {
        emit(
          state.copyWith(
            requestSatutsAllShows: RequestSatuts.loaded,
            forYouList: r,
          ),
        );
      });
    }
  }

  Future<FutureOr<void>> _getAllShowEvent(
      GetAllShowEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        requestSatutsAllShows: RequestSatuts.loading,
        allShowList: state.allShowList,
      ),
    );
    final result = await getMoviesBySearch.fetchAllShowsForSearch(
        randomPage: Random().nextInt(100));

    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsAllShows: RequestSatuts.failure,
        ),
      );
    }, (r) {
      print("r ()=> $r  , All Shows");

      if (r.isEmpty) {
        emit(
          state.copyWith(
            requestSatutsSearchLoading: RequestSatuts.empty,
            message: "Not Found Results",
            allShowList: [],
            searchController: state.searchController,
          ),
        );
      } else {
        final filiterList = filiterCoversCollections(r);
        emit(
          state.copyWith(
            allShowList: filiterList,
            requestSatutsAllShows: RequestSatuts.loaded,
          ),
        );
      }
    });
  }

  Future<FutureOr<void>> _loadMoreDataAllShowsEvent(
      LoadMoreDataAllShowsEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        requestSatutsAllShows: RequestSatuts.loaded,
        allShowList: state.allShowList,
      ),
    );
    final result = await getMoviesBySearch.fetchAllShowsForSearch(
        randomPage: Random().nextInt(100));

    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsSearchLoading: RequestSatuts.loaded,
        ),
      );
    }, (r) {
      final filiterList = filiterCoversCollections(r);

      emit(
        state.copyWith(
          requestSatutsSearchLoading: RequestSatuts.loaded,
          getMoreResults: false,
          allShowList: List.of(state.allShowList)..addAll(filiterList),
        ),
      );
    });
  }

  Future<FutureOr<void>> _getMoviesEvent(
      GetMoviesEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        requestSatutsMoviesList: RequestSatuts.loading,
      ),
    );

    final result = await getMoviesBySearch.fetchMovieForSearch(
        randomPage: Random().nextInt(100));

    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsMoviesList: RequestSatuts.failure,
        ),
      );
    }, (r) {
      print("r ()=> $r  ,  Get Movies");
      if (r.isEmpty) {
        emit(
          state.copyWith(
            requestSatutsMoviesList: RequestSatuts.empty,
            message: "Not Found Results",
            movieList: [],
            searchController: state.searchController,
          ),
        );
      } else {
        final filiterList = filiterCoversCollections(r);

        emit(
          state.copyWith(
            movieList: filiterList,
            requestSatutsMoviesList: RequestSatuts.loaded,
          ),
        );
      }
    });
  }

  Future<FutureOr<void>> _loadMoreDataMoviesEvent(
      LoadMoreDataMoviesEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        requestSatutsMoviesList: RequestSatuts.loaded,
        movieList: state.movieList,
      ),
    );

    final result = await getMoviesBySearch.fetchMovieForSearch(
        randomPage: Random().nextInt(100));

    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsMoviesList: RequestSatuts.loaded,
          getMoreResults: false,
          movieList: state.movieList,
        ),
      );
    }, (r) {
      final filiterList = filiterCoversCollections(r);

      emit(
        state.copyWith(
          requestSatutsMoviesList: RequestSatuts.loaded,
          movieList: List.of(state.movieList)..addAll(filiterList),
        ),
      );
    });
  }

  Future<FutureOr<void>> _getTvShowsEvent(
      GetTvShowsEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        requestSatutsTvShows: RequestSatuts.loading,
      ),
    );

    final result = await getMoviesBySearch.fetchTvShowsForSearch(
        randomPage: Random().nextInt(100));

    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsTvShows: RequestSatuts.failure,
        ),
      );
    }, (r) {
      print("r ()=> $r  ,  Tv Shows");

      if (r.isEmpty) {
        emit(
          state.copyWith(
            requestSatutsTvShows: RequestSatuts.empty,
            message: "Not Found Results",
            tvShowsList: [],
            searchController: state.searchController,
          ),
        );
      } else {
        
        emit(
          state.copyWith(
            tvShowsList: r,
            getMoreResults: false,
            requestSatutsTvShows: RequestSatuts.loaded,
          ),
        );
      }
    });
  }

  Future<FutureOr<void>> _getLoadMoreDataTvShowsEvent(
      LoadMoreDataTvShowsEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        requestSatutsTvShows: RequestSatuts.loaded,
        tvShowsList: state.tvShowsList,
      ),
    );
    final result = await getMoviesBySearch.fetchTvShowsForSearch(
        randomPage: Random().nextInt(100));

    result.fold((l) {
      emit(
        state.copyWith(
          requestSatutsTvShows: RequestSatuts.failure,
          getMoreResults: false,
          tvShowsList: state.tvShowsList,
        ),
      );
    }, (r) {
      emit(
        state.copyWith(
          requestSatutsTvShows: RequestSatuts.loaded,
          getMoreResults: false,
          tvShowsList: List.of(state.tvShowsList)..addAll(r),
        ),
      );
    });
  }

  List<SearchHomeModel> filiterCoversCollections(List<SearchHomeModel> r) {
    final list = r
        .where((movie) =>
            movie.posterPath != "null" &&
            movie.title != "null" &&
            movie.overview != "null")
        .map((movie) => movie)
        .toList();

    return list;
  }
}
