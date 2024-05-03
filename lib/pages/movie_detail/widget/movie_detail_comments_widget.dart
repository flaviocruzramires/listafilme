import 'package:flutter/material.dart';
import 'package:listafilmes/data/models/movie.dart';
import 'package:listafilmes/pages/movie_detail/movie_detail_controller.dart';
import 'package:listafilmes/service_locator.dart';
import 'package:timeago/timeago.dart' as timeago;

class MovieDetailCommentsWidget extends StatelessWidget {
  MovieDetailCommentsWidget({super.key, required this.movie});

  final controller = getIt<MovieDetailController>();

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: movie.comments.length,
      itemBuilder: (context, index) {
        var comment = movie.comments[index];
        return Column(
          children: [
            ListTile(
              title: Text(comment.comment),
              subtitle: Row(children: [
                Text(
                  timeago.format(
                    comment.createdAt,
                    allowFromNow: true,
                    locale: 'pt_BR',
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact),
                  child: const Icon(Icons.thumb_up_alt_outlined),
                )
              ]),
              trailing: InkWell(
                child: const Icon(Icons.delete),
                onTap: () async {
                  await controller.deleteComment(comment.id).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          margin: EdgeInsets.all(16),
                          backgroundColor: Colors.green,
                          content: Text('Comentário excluido'),
                        ),
                      );
                      controller.getMovie();
                    },
                    onError: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.shade200,
                          content: Text(
                            error.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(
              color: Color.fromRGBO(94, 97, 153, 1),
            ),
          ],
        );
      },
    );
  }
}
