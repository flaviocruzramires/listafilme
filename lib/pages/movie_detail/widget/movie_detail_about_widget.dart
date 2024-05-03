import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:listafilmes/data/models/movie.dart';

class MovieDetailAboutWidget extends StatelessWidget {
  const MovieDetailAboutWidget({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Synopse', //movie.name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Column(
              children: [
                const Divider(color: Color.fromRGBO(94, 97, 153, 1)),
                Text(
                  movie.description,
                  textAlign: TextAlign.justify,
                ),
                const Divider(
                  color: Colors.transparent,
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildIcon(Icons.calendar_month_rounded),
                ),
                Text(
                  movie.year.toString(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildIcon(Icons.timer),
                ),
                const SizedBox(height: 30),
                Text(
                  prettyDuration(
                    Duration(
                      minutes: movie.duration,
                    ),
                    abbreviated: true,
                    delimiter: '',
                    spacer: '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildIcon(Icons.category),
                ),
                Text(movie.gender),
              ],
            ),
            const Divider(color: Color.fromRGBO(94, 97, 153, 1)),
          ],
        ),
      ),
    );
  }

  Icon _buildIcon(IconData icon) => Icon(icon);
}
