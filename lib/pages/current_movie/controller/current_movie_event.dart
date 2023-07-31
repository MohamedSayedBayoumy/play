// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_movie_bloc.dart';

abstract class CurrentMovieEvent extends Equatable {
  const CurrentMovieEvent();

  @override
  List<Object> get props => [];
}

class GetVedioIdEvent extends CurrentMovieEvent {
  final int movieId;
  const GetVedioIdEvent({required this.movieId});
}

class GetTypeMovieEvent extends CurrentMovieEvent {
  final int movieId;
  const GetTypeMovieEvent({required this.movieId});
}

class GetImagesMovieEvent extends CurrentMovieEvent {
  final int movieId;
  const GetImagesMovieEvent({required this.movieId});
}

class GetLastAndNextEpisodeEvent extends CurrentMovieEvent {
  final int movieId;
  const GetLastAndNextEpisodeEvent({required this.movieId});
}

class GetActorsEvent extends CurrentMovieEvent {
  final int movieId;
  const GetActorsEvent({required this.movieId});
}

class GetRecommendationEvent extends CurrentMovieEvent {
  final int movieId;
  const GetRecommendationEvent({required this.movieId});
}