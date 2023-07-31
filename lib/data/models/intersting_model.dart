// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class AllMovieModel extends Equatable {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  AllMovieModel({this.page, this.results, this.totalPages, this.totalResults});

  AllMovieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  @override
  List<Object> get props => [page!, results!, totalPages!, totalResults!];
}

class Results extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;

  Results(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'] ?? "null";
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'] ?? "";
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'] ?? "null";
    releaseDate = json['release_date'] ?? "//";
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  @override
  List<Object> get props {
    return [
      adult!,
      backdropPath!,
      genreIds!,
      id!,
      originalLanguage!,
      originalTitle!,
      overview!,
      popularity!,
      posterPath!,
      releaseDate!,
      title!,
      video!,
      voteAverage!,
      voteCount!,
    ];
  }
}
