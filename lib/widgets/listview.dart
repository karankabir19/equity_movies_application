// Packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Common
import '../common/colors.dart';

// Screen
import '../screens/movie_details_screen.dart';

class ListViewWidget extends StatefulWidget {
  final List<dynamic> movies;
  const ListViewWidget(this.movies, {super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
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
            height: 150,
            child: Row(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 1,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
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
                        'Rating:- ${movie.rating}',
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
    );
  }
}
