// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_constance/app_constance.dart';
import '../../../data/models/search_home_model.dart';
import '../../../data/models/search_model.dart';

class SearchState extends Equatable {
  final RequestSatuts requestSatutsForYou;
  final RequestSatuts requestSatutsAllShows;
  final RequestSatuts requestSatutsMoviesList;
  final RequestSatuts requestSatutsSearchLoading;
  final RequestSatuts requestSatutsTvShows;
  final List<SearchModel> collectionSearchList;
  final List<SearchHomeModel> forYouList;
  final List<SearchHomeModel> allShowList;
  final List<SearchHomeModel> movieList;
  final List<SearchModel> tvShowsList;
  final TextEditingController searchController;
  final String message;
  final bool getMoreResults;

  const SearchState({
    required this.searchController,
    this.message = " ",
    this.getMoreResults = false,
    this.requestSatutsAllShows = RequestSatuts.loading,
    this.requestSatutsForYou = RequestSatuts.loading,
    this.requestSatutsTvShows = RequestSatuts.loading,
    this.requestSatutsSearchLoading = RequestSatuts.loading,
    this.requestSatutsMoviesList = RequestSatuts.loading,
    this.collectionSearchList = const [],
    this.allShowList = const [],
    this.movieList = const [],
    this.tvShowsList = const [],
    this.forYouList = const [],
  });

  SearchState copyWith({
    String? message,
    bool? getMoreResults,
    RequestSatuts? requestSatutsForYou,
    RequestSatuts? requestSatutsAllShows,
    RequestSatuts? requestSatutsSearchLoading,
    RequestSatuts? requestSatutsMoviesList,
    RequestSatuts? requestSatutsTvShows,
    List<SearchModel>? collectionSearchList,
    List<SearchHomeModel>? forYouList,
    List<SearchHomeModel>? allShowList,
    List<SearchHomeModel>? movieList,
    List<SearchModel>? tvShowsList,
    TextEditingController? searchController,
  }) =>
      SearchState(
          getMoreResults: getMoreResults ?? this.getMoreResults,
          message: message ?? this.message,
          searchController: searchController ?? this.searchController,
          requestSatutsTvShows:
              requestSatutsTvShows ?? this.requestSatutsTvShows,
          requestSatutsSearchLoading:
              requestSatutsSearchLoading ?? this.requestSatutsSearchLoading,
          requestSatutsMoviesList:
              requestSatutsMoviesList ?? this.requestSatutsMoviesList,
          allShowList: allShowList ?? this.allShowList,
          forYouList: forYouList ?? this.forYouList,
          movieList: movieList ?? this.movieList,
          tvShowsList: tvShowsList ?? this.tvShowsList,
          collectionSearchList:
              collectionSearchList ?? this.collectionSearchList,
          requestSatutsAllShows:
              requestSatutsAllShows ?? this.requestSatutsAllShows,
          requestSatutsForYou: requestSatutsForYou ?? this.requestSatutsForYou);

  @override
  List<Object> get props {
    return [
      requestSatutsForYou,
      requestSatutsAllShows,
      requestSatutsSearchLoading,
      collectionSearchList,
      forYouList,
      allShowList,
      movieList,
      tvShowsList,
      searchController,
      message,
      getMoreResults
    ];
  }
}
