import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:listafilmes/data/models/movie.dart';
import 'package:listafilmes/pages/movie_detail/movie_detail_page.dart';

class MovieItemWidget extends StatelessWidget {
  const MovieItemWidget({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(
              movie.urlImage,
              width: 120,
              height: 154,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Row(children: [
                Text(prettyDuration(
                  Duration(
                    minutes: movie.duration,
                  ),
                  abbreviated: true,
                  delimiter: '',
                  spacer: '',
                )),
                const Text(' - '),
                Text(movie.gender)
              ]),
              Text(
                movie.year.toString(),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 130),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailPage(movie: movie)),
                        );
                      },
                      child: const Icon(
                        Icons.comment,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
