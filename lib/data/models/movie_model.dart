// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  String? backdropPath;
  String? firstAirDate;
  List<num>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  num? popularity;
  String? posterPath;
  num? voteAverage;
  num? voteCount;

  MovieModel(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  MovieModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'] ?? "null";
    firstAirDate = json['first_air_date'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    name = json['name'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'] ?? "null";
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  @override
  List<Object> get props {
    return [
      backdropPath!,
      firstAirDate!,
      genreIds!,
      id!,
      name!,
      originCountry!,
      originalLanguage!,
      originalName!,
      overview!,
      popularity!,
      posterPath!,
      voteAverage!,
      voteCount!
    ];
  }
}
