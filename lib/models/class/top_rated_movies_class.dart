class TopRatedMovie {
  final int id;
  final String title;
  final String releaseDate;
  final String posterPath;
  final dynamic rating;

  TopRatedMovie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.rating,
  });

  factory TopRatedMovie.fromJson(Map<String, dynamic> json) {
    return TopRatedMovie(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      rating: json['vote_average'],
    );
  }
}
