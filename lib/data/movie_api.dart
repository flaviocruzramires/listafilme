import 'package:dio/dio.dart';
import 'package:listafilmes/data/app_interceptor.dart';
import 'package:listafilmes/data/models/movie.dart';

class MovieApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://apifilmes.webevolui.com',
    ),
  );

  MovieApi() {
    _dio.interceptors.add(AppInterceptor());
  }

  Future<List<Movie>> getMovies({
    int skip = 0,
    int take = 3,
  }) async {
    final response = await _dio.get('/filme?skip=$skip&take=$take');
    return (response.data as List).map((item) => Movie.fromJson(item)).toList();
  }

  Future<List<Movie>> seachrMovie(String query) async {
    final response = await _dio.get('/filme?q=$query');
    return (response.data as List).map((item) => Movie.fromJson(item)).toList();
  }

  Future<Movie> getMovie(int id) async {
    final response = await _dio.get('/filme/$id');
    return Movie.fromJson(response.data);
  }

  Future<void> deleteComment(int idMovie, int idComment) async {
    await _dio.delete('/Filme/$idMovie/Comentario/$idComment');
  }

  Future<void> postComment(int idMovie, String comment) async {
    await _dio.post(
      '/Filme/$idMovie/Comentario/',
      data: {
        'comment': comment,
      },
    );
  }
}
