 

class TypeMovieModel {
  List<String>? descriptors;
  String? iso31661;
  String? rating;

  TypeMovieModel({this.descriptors, this.iso31661, this.rating});

  TypeMovieModel.fromJson(Map<String, dynamic> json) {
    descriptors = json['descriptors'].cast<String>();
    iso31661 = json['iso_3166_1'];
    rating = json['rating'];
  }
}
