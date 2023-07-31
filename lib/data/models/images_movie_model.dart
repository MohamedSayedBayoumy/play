class ImagesMovieModel {
  List<Backdrops>? backdrops;
  int? id;
  List<Logos>? logos;
  List<Posters>? posters;

  ImagesMovieModel({this.backdrops, this.id, this.logos, this.posters});

  ImagesMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = <Backdrops>[];
      json['backdrops'].forEach((v) {
        backdrops!.add(Backdrops.fromJson(v));
      });
    }
    id = json['id'];
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(Logos.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = <Posters>[];
      json['posters'].forEach((v) {
        posters!.add(Posters.fromJson(v));
      });
    }
  }
}

class Backdrops {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Backdrops(
      {this.aspectRatio,
      this.height,
      this.iso6391,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
}

class Posters {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Posters(
      {this.aspectRatio,
      this.height,
      this.iso6391,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});

  Posters.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
}

class Logos {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Logos(
      {this.aspectRatio,
      this.height,
      this.iso6391,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});

  Logos.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
}
