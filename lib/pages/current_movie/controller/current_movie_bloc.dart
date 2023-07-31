// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:play/core/utils/app_constance/app_constance.dart';
import '../../../data/repository_pattern/remote_data/get_current_movie_data.dart';
import 'current_movie_state.dart';

part 'current_movie_event.dart';

class CurrentMovieBloc extends Bloc<CurrentMovieEvent, CurrentMovieState> {
  CurrentMovieBloc(this.getCurrentMovieDetails)
      : super(const CurrentMovieState()) {
    on<GetVedioIdEvent>(_getVedioIdEvent);
    on<GetImagesMovieEvent>(_getImagesMovieEvent);

    on<GetTypeMovieEvent>(_getTypeMovieEvent);
    on<GetRecommendationEvent>(_getRecommendationEvent);
  }

  final GetCurrentMovieDetails getCurrentMovieDetails;

  Future<FutureOr<void>> _getVedioIdEvent(
      GetVedioIdEvent event, Emitter<CurrentMovieState> emit) async {
    emit(
      state.copyWith(
        requestSatuts: RequestSatuts.loading,
      ),
    );

    final result = await getCurrentMovieDetails.getCurrentMovieVedio(
      movieId: event.movieId,
    );

    result.fold((l) {
      emit(state.copyWith(
        requestSatuts: RequestSatuts.failure,
      ));
    }, (r) {
      if (r.isEmpty) {
        emit(
          state.copyWith(
            youtubeIdModel: r,
          ),
        );
        print("Vedios is ()= > $r");
        add(GetImagesMovieEvent(movieId: event.movieId));
      } else {
        emit(
          state.copyWith(
            youtubeIdModel: r,
          ),
        );
        add(GetTypeMovieEvent(movieId: event.movieId));
      }
    });
  }

  Future<FutureOr<void>> _getImagesMovieEvent(
      GetImagesMovieEvent event, Emitter<CurrentMovieState> emit) async {
    final result = await getCurrentMovieDetails.getCurrentMovieImages(
      movieId: event.movieId,
    );

    result.fold((l) {
      emit(state.copyWith(
        requestSatuts: RequestSatuts.failure,
      ));
    }, (r) {
      print("Images is ()= > $r");

      emit(
        state.copyWith(
          imagesMovieModel: r,
        ),
      );
      add(GetTypeMovieEvent(movieId: event.movieId));
    });
  }

  Future<FutureOr<void>> _getTypeMovieEvent(
      GetTypeMovieEvent event, Emitter<CurrentMovieState> emit) async {
    final result = await getCurrentMovieDetails.getCurrentMovieType(
      movieId: event.movieId,
    );

    result.fold((l) {
      emit(state.copyWith(
        requestSatuts: RequestSatuts.failure,
      ));
    }, (r) {
      if (r.isEmpty) {
        emit(
          state.copyWith(
            requestSatuts: RequestSatuts.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            typeMovieModel: r,
          ),
        );
        add(GetRecommendationEvent(movieId: event.movieId));
      }
    });
  }

  Future<FutureOr<void>> _getRecommendationEvent(
      GetRecommendationEvent event, Emitter<CurrentMovieState> emit) async {
    final result = await getCurrentMovieDetails.getRecommendationMovieType(
      movieId: event.movieId,
    );

    result.fold((l) {
      emit(state.copyWith(
        requestSatuts: RequestSatuts.failure,
      ));
    }, (r) {
      if (r.isEmpty) {
        emit(
          state.copyWith(
            recommendationList: r,
          ),
        );
      } else {
        final filiterList = r
            .where(
              (movie) =>
                  movie.posterPath != "null" &&
                  movie.backdropPath != "null" &&
                  movie.name != "null" &&
                  movie.overview != "null",
            )
            .map((movie) => movie)
            .toList();

        emit(
          state.copyWith(
            recommendationList: filiterList,
            requestSatuts: RequestSatuts.loaded,
          ),
        );
      }
    });
  }
}
