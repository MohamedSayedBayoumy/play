import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class GetOnAirMovieEvent extends HomeScreenEvent {}

class GetSpecialMovieForUserEvent extends HomeScreenEvent {}

class GetPopluarMovieEvent extends HomeScreenEvent {}

class GetTopRatedMovieEvent extends HomeScreenEvent {}

class GetUpComingMovieEvent extends HomeScreenEvent {}

class GetCartoonMovieEvent extends HomeScreenEvent {}

class GetCollectionsEvent extends HomeScreenEvent {}

class GetComdyMovieEvent extends HomeScreenEvent {}

class GetCrimeMovieEvent extends HomeScreenEvent {}
