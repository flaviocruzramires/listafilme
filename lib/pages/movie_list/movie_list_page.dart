import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:listafilmes/data/models/movie.dart';
import 'package:listafilmes/pages/movie_list/movie_list_controller.dart';
import 'package:listafilmes/pages/movie_list/movie_search_delegate.dart';
import 'package:listafilmes/pages/movie_list/widgets/movie_item_widget.dart';
import 'package:listafilmes/pages/movie_list/widgets/progress_indicator_widget.dart';
import 'package:listafilmes/service_locator.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final controller = getIt<MovieListController>();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Filmes'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MovieSearchDelegate(),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            )
          ],
        ),
        body: PagedListView(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Movie>(
            itemBuilder: (context, movie, index) {
              return MovieItemWidget(movie: movie);
            },
          ),
        )
        /*
      body: StreamBuilder<List<Movie>>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: ProgressIndicatorWidget(),
            );
          }
          var movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return MovieItemWidget(movie: movie);
            },
          );
        },
      ),*/
        );
  }
}
