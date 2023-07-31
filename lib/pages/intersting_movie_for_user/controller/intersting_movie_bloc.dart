// ignore_for_file: avoid_print, unnecessary_null_comparison, null_check_always_fails

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../core/utils/app_constance/app_constance.dart';
import '../../../data/repository_pattern/remote_data/get_intersting_movie.dart';
import 'intersting_movie_event.dart';
import 'intersting_movie_state.dart';

class InterstingMovieBloc
    extends Bloc<InterstingMovieEvent, InterstingMovieState> {
  InterstingMovieBloc(this.getIntrestingMovie) : super(InterstingMovieState()) {
    on<LoadGetInterstingMovieEvent>(_loadGetInterstingMovieEvent);
    on<SelectItemEvent>(_selectItemEvent);
  }
  final GetIntrestingMovie getIntrestingMovie;

  Future<FutureOr<void>> _loadGetInterstingMovieEvent(
      LoadGetInterstingMovieEvent event,
      Emitter<InterstingMovieState> emit) async {
    {
      emit(
        state.copyWith(
          request: RequestSatuts.loading,
        ),
      );
      final result = await getIntrestingMovie.getIntrestingMovie();
      result.fold((l) {
        emit(state.copyWith(
            request: RequestSatuts.failure, errorMessage: l.message));
      }, (r) {
        final filiterList = r.results!
            .where((movie) => movie.posterPath != "null")
            .map((movie) => movie)
            .toList();
        emit(state.copyWith(
            request: RequestSatuts.loaded, interstingMovieModel: filiterList));
      });
    }
  }

  FutureOr<void> _selectItemEvent(
      SelectItemEvent event, Emitter<InterstingMovieState> emit) {
    final data = state.interstMovieList.firstWhere(
      (element) =>
          element == state.interstingMovieModel![event.index].id,
      orElse: () {
        if (state.interstMovieList.length <= 2) {
          emit(
            state.copyWith(
              interstMovieList: Set.of(state.interstMovieList)
                ..add(
                  state.interstingMovieModel![event.index].id!,
                ),
            ),
          );
        }
        return 0;
      },
    );

    if (state.interstingMovieModel![event.index].id == data) {
      emit(
        state.copyWith(
          interstMovieList: Set.of(state.interstMovieList)
            ..remove(
              data,
            ),
        ),
      );
    }
  }
}
