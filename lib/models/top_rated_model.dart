import './class/top_rated_movies_class.dart';

class TopRatedModel {
  final List<TopRatedMovie> results;

  TopRatedModel({required this.results});

  factory TopRatedModel.fromJson(Map<String, dynamic> json) {
    return TopRatedModel(
      results: List<TopRatedMovie>.from(
        json['results'].map(
          (x) => TopRatedMovie.fromJson(x),
        ),
      ),
    );
  }
}
