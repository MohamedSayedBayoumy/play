class RecommendationModel {
  bool? adult;
  String? backdropPath;
  num? id;
  String? name;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  String? mediaType;
  List<num>? genreIds;
  double? popularity;
  String? firstAirDate;
  num? voteAverage;
  num? voteCount;
  List<String>? originCountry;

  RecommendationModel(
      {this.adult,
      this.backdropPath,
      this.id,
      this.name,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.posterPath,
      this.mediaType,
      this.genreIds,
      this.popularity,
      this.firstAirDate,
      this.voteAverage,
      this.voteCount,
      this.originCountry});

  RecommendationModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'] ?? "null";
    id = json['id'];
    name = json['name']?? "null";
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview']?? "null";
    posterPath = json['poster_path']?? "null";
    mediaType = json['media_type'];
    genreIds = json['genre_ids'].cast<int>();
    popularity = json['popularity'];
    firstAirDate = json['first_air_date'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    originCountry = json['origin_country'].cast<String>();
  }
}
