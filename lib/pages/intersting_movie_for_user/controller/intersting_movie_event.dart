// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class InterstingMovieEvent extends Equatable {}

class LoadGetInterstingMovieEvent extends InterstingMovieEvent {
  @override
  List<Object?> get props => [];
}

class SelectItemEvent extends InterstingMovieEvent {
  final int index;
  SelectItemEvent({
    required this.index,
  });

  @override
  List<Object?> get props => [];
}

class ClearListEvent extends InterstingMovieEvent {
  ClearListEvent();

  @override
  List<Object?> get props => [];
}
