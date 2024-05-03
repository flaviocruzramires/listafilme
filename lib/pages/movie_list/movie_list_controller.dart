import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:listafilmes/data/models/movie.dart';
import 'package:listafilmes/data/movie_api.dart';
import 'package:listafilmes/service_locator.dart';

class MovieListController {
  final api = getIt<MovieApi>();
  final int _pageSize = 3;
  final PagingController<int, Movie> pagingController = PagingController(
    firstPageKey: 0,
  );

  void init() {
    pagingController.addPageRequestListener((pageKey) {
      getMovies(pageKey);
    });
    //getMovies();
  }

  Future<void> getMovies(int pageKey) async {
    try {
      var result = await api.getMovies(skip: pageKey, take: _pageSize);

      final isLastPage = result.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(result);
      } else {
        final nextPageKey = pageKey + result.length;
        pagingController.appendPage(result, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
/*
  void getMovies() async {
    var result = await api.getMovies();
    _controller.sink.add(result);
  }
*/
/*
  void searchMovie(String query) async {
    var result = await api.seachrMovie(query);
    _controller.sink.add(result);
  }
  */

