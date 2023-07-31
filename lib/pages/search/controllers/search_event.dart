// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMoviesEvent extends SearchEvent {
  final String quary;
  final int? page;

  const SearchMoviesEvent({
    required this.quary,
    required this.page,
  });
}

class GetForYouEvent extends SearchEvent {}

class GetAllShowEvent extends SearchEvent {
  const GetAllShowEvent();
}

class LoadMoreDataAllShowsEvent extends SearchEvent {}

class GetMoviesEvent extends SearchEvent {
  const GetMoviesEvent();
}

class LoadMoreDataMoviesEvent extends SearchEvent {}

class GetTvShowsEvent extends SearchEvent {
  const GetTvShowsEvent();
}

class LoadMoreDataTvShowsEvent extends SearchEvent {}
