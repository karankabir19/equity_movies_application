class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final double rating;
  final String releaseDate;
  final String image;

  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    required this.image,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      rating: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
      image: json['poster_path'],
    );
  }
}
