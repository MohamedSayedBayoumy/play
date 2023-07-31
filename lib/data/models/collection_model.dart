class CollectionModel {
  bool? adult;
  String? backdropPath;
  int? id;
  String? name;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;

  CollectionModel(
      {this.adult,
      this.backdropPath,
      this.id,
      this.name,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.posterPath});

  CollectionModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'] ?? "null";
    id = json['id'];
    name = json['name'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'] ?? "null";
  }

  void forEach(Null Function(dynamic key) param0) {}
}
