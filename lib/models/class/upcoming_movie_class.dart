class UpcomingMovie {
  final int id;
  final String title;
  final String releaseDate;
  final String posterPath;
  final dynamic rating;

  UpcomingMovie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.rating,
  });

  factory UpcomingMovie.fromJson(Map<String, dynamic> json) {
    return UpcomingMovie(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      rating: json['vote_average'],
    );
  }
}
