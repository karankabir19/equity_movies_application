import './class/upcoming_movie_class.dart';

class UpcomingModel {
  final List<UpcomingMovie> results;

  UpcomingModel({required this.results});

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      results: List<UpcomingMovie>.from(
        json['results'].map(
          (x) => UpcomingMovie.fromJson(x),
        ),
      ),
    );
  }
}
