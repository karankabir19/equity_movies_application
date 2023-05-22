// Package
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Models
import '../models/class/top_rated_movies_class.dart';
import '../models/top_rated_model.dart';

// Widgets
import '../widgets/gridview.dart';
import '../widgets/listview.dart';

class TopRated extends StatefulWidget {
  final bool isListView;
  const TopRated({super.key, required this.isListView});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  List<TopRatedMovie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchNowPlayingMovies();
  }

  Future<void> fetchNowPlayingMovies() async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/top_rated',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MGIxN2EyZDU5ZTE4NmNiNDdmMWQyMTViY2I3MDU2YSIsInN1YiI6IjY0Njg1ZTgzMzNhMzc2MDE3NWQyOTE4YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hlDOkFEh5T8yEBrMo7sz6HE4s99XQBhvbaAqo-sarvk',
          },
        ),
      );

      final nowPlayingModel = TopRatedModel.fromJson(response.data);
      setState(() {
        movies = nowPlayingModel.results;
      });
    } catch (error) {
      print('Request failed with error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child:
            widget.isListView ? ListViewWidget(movies) : GridViewWidget(movies),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
