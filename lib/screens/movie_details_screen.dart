// Package
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Common
import '../common/colors.dart';

// Models
import '../models/class/movie_details_class.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetails? movie;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/${widget.movieId}',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MGIxN2EyZDU5ZTE4NmNiNDdmMWQyMTViY2I3MDU2YSIsInN1YiI6IjY0Njg1ZTgzMzNhMzc2MDE3NWQyOTE4YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hlDOkFEh5T8yEBrMo7sz6HE4s99XQBhvbaAqo-sarvk',
          },
        ),
      );

      setState(() {
        movie = MovieDetails.fromJson(response.data);
      });
    } catch (e) {
      print('Error fetching movie details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: movie == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'Movie Details',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: iconColor,
                    ),
                  ),
                  floating: true,
                  snap: true,
                  elevation: 0,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Image.network(
                          'https://image.tmdb.org/t/p/w200${movie!.image}',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          movie!.title,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rating: ${movie!.rating.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Release Date: ${movie!.releaseDate}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie!.overview,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
