import 'package:flutter/material.dart';
import 'package:listafilmes/data/models/movie.dart';
import 'package:listafilmes/pages/movie_detail/movie_detail_controller.dart';
import 'package:listafilmes/pages/movie_detail/widget/add_comment_widget.dart';
import 'package:listafilmes/pages/movie_detail/widget/movie_detail_about_widget.dart';
import 'package:listafilmes/pages/movie_detail/widget/movie_detail_comments_widget.dart';
import 'package:listafilmes/pages/movie_detail/widget/movie_detail_cover.dart';
import 'package:listafilmes/pages/movie_list/widgets/progress_indicator_widget.dart';
import 'package:listafilmes/service_locator.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final controller = getIt.registerSingleton(MovieDetailController());

  @override
  void initState() {
    controller.init(widget.movie);
    super.initState();
  }

  @override
  void dispose() {
    getIt.unregister(instance: controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Movie>(
        initialData: widget.movie,
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProgressIndicatorWidget();
          }
          var movie = snapshot.data!;
          return CustomScrollView(
            slivers: [
              MovieDetailCover(movie: movie),
              MovieDetailAboutWidget(movie: movie),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Comentários',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                const SliverToBoxAdapter(
                  child: ProgressIndicatorWidget(),
                )
              else if (movie.comments.isEmpty)
                const SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Nenhum comentário para mostrar',
                    ),
                  ),
                )
              else
                MovieDetailCommentsWidget(movie: movie),
              AddCommentWidget()
            ],
          );
        },
      ),
    );
  }
}
