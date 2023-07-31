// ignore_for_file: must_be_immutable

 
class SearchHomeModel {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  List<dynamic>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  SearchHomeModel(
      {this.adult,
      this.backdropPath,
      this.id,
      this.title,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.mediaType,
      this.genreIds,
      this.popularity,
      this.releaseDate,
      this.video,
      this.voteAverage,
      this.voteCount});

  SearchHomeModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'] ?? "null";
    id = json['id'];
    title = json['title'] ?? "null";
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'] ?? "null";
    posterPath = json['poster_path'] ?? "null";
    mediaType = json['media_type'];
    genreIds = json['genre_ids'] ?? [];
    popularity = json['popularity'];
    releaseDate = json['release_date'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}
