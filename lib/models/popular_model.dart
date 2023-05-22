import './class/popular_movie_class.dart';

class PopularModel {
  final List<PopularMovie> results;

  PopularModel({required this.results});

  factory PopularModel.fromJson(Map<String, dynamic> json) {
    return PopularModel(
      results: List<PopularMovie>.from(
        json['results'].map(
          (x) => PopularMovie.fromJson(x),
        ),
      ),
    );
  }
}
