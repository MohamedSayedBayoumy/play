// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../core/utils/app_constance/app_constance.dart';
import '../../../data/models/intersting_model.dart';

class InterstingMovieState extends Equatable {
  bool isFullList = false;

  Set<int> interstMovieList = {};

  final RequestSatuts request;

  final String errorMessage;
  final bool reserButtonIsActive;

  List<Results>? interstingMovieModel;
  InterstingMovieState({
    this.isFullList = false,
    this.interstingMovieModel = const [],
    this.interstMovieList = const {},
    this.errorMessage = " ",
    this.request = RequestSatuts.loading,
    this.reserButtonIsActive = false,
  });

  InterstingMovieState copyWith({
    bool? isFullList,
    Set<int>? interstMovieList,
    RequestSatuts? request,
    String? errorMessage,
    bool? reserButtonIsActive,
    List<Results>? interstingMovieModel,
  }) =>
      InterstingMovieState(
        reserButtonIsActive: reserButtonIsActive ?? this.reserButtonIsActive,
        errorMessage: errorMessage ?? this.errorMessage,
        request: request ?? this.request,
        interstingMovieModel: interstingMovieModel ?? this.interstingMovieModel,
        isFullList: isFullList ?? this.isFullList,
        interstMovieList: interstMovieList ?? this.interstMovieList,
      );

  @override
  List<Object> get props => [
        isFullList,
        errorMessage,
        request,
        interstMovieList,
        reserButtonIsActive ,
        
      ];
}
