// Package
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Common
import '../common/colors.dart';

// Screens
import '../screens/movie_details_screen.dart';

class GridViewWidget extends StatefulWidget {
  final List<dynamic> movies;
  const GridViewWidget(this.movies, {super.key});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.movies.length,
      itemBuilder: (context, index) {
        final movie = widget.movies[index];
        return GestureDetector(
          onTap: () {
            Get.to(
              () => MovieDetailsPage(
                movieId: widget.movies[index].id,
              ),
            );
          },
          child: SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  movie.releaseDate,
                  style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Rating: ${movie.rating}',
                  style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
