import './class/now_playing_movies_class.dart';

class NowPlayingModel {
  final List<NowPlayingMovie> results;

  NowPlayingModel({required this.results});

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) {
    return NowPlayingModel(
      results: List<NowPlayingMovie>.from(
        json['results'].map(
          (x) => NowPlayingMovie.fromJson(x),
        ),
      ),
    );
  }
}
