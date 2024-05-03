import 'package:listafilmes/data/models/movie.dart';
import 'package:listafilmes/data/movie_api.dart';
import 'package:listafilmes/service_locator.dart';

class MovieSearchController {
  final api = getIt<MovieApi>();

  Future<List<Movie>> searchMovie(String query) async {
    var result = await api.seachrMovie(query);
    return result;
  }
}
