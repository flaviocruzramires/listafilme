import 'package:flutter/material.dart';
import 'package:listafilmes/data/models/movie.dart';
import 'package:listafilmes/pages/movie_detail/movie_search_controller.dart';
import 'package:listafilmes/pages/movie_list/widgets/movie_item_widget.dart';
import 'package:listafilmes/pages/movie_list/widgets/progress_indicator_widget.dart';

class MovieSearchDelegate extends SearchDelegate {
  final controller = MovieSearchController();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return buildSuggestions(context);
    }
    if (query.length < 3) {
      return Container(
        color: Colors.black54,
        child: Text(
            'A consulta informada : "$query" deve ter pelo menos 3 caracteres'),
      );
    } else {
      return FutureBuilder(
        future: controller.searchMovie(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: ProgressIndicatorWidget(),
            );
          } else {
            List<Movie>? movies = snapshot.data! as List<Movie>?;

            if (movies!.isEmpty) {
              return Container(
                color: Colors.black54,
                child: Text('Nenhum resultado encontrado para : "$query"'),
              );
            }
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movie = movies[index];
                return MovieItemWidget(movie: movie);
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
