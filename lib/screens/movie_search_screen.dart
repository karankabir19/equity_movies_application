// Package
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Common
import '../common/colors.dart';

// Models
import '../models/class/now_playing_movies_class.dart';
import '../models/now_playing_model.dart';

// Screen
import './movie_details_screen.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final searchController = TextEditingController();

  List<NowPlayingMovie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchNowPlayingMovies();
  }

  Future<void> fetchNowPlayingMovies() async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/now_playing',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MGIxN2EyZDU5ZTE4NmNiNDdmMWQyMTViY2I3MDU2YSIsInN1YiI6IjY0Njg1ZTgzMzNhMzc2MDE3NWQyOTE4YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hlDOkFEh5T8yEBrMo7sz6HE4s99XQBhvbaAqo-sarvk',
          },
        ),
      );

      final nowPlayingModel = NowPlayingModel.fromJson(response.data);
      setState(() {
        movies = nowPlayingModel.results;
      });
    } catch (error) {
      print('Request failed with error: $error');
    }
  }

  List<NowPlayingMovie> searchResults = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchMovies(String query) {
    setState(
      () {
        searchResults = movies
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'Movie Search',
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
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                searchMovies(value);
              },
              decoration: const InputDecoration(
                labelText: 'Search Movies',
                prefixIcon: Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No data found',
                        style: TextStyle(color: textColor),
                      ),
                    )
                  : ListView.separated(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => MovieDetailsPage(
                                movieId: searchResults[index].id,
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Image.network(
                              'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                            title: Text(
                              movie.title,
                              style: const TextStyle(color: textColor),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, i) => const SizedBox(
                        height: 10,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
