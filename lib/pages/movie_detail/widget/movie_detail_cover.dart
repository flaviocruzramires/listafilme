import 'package:flutter/material.dart';
import 'package:listafilmes/data/models/movie.dart';

class MovieDetailCover extends StatelessWidget {
  const MovieDetailCover({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      stretch: true,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              movie.urlImage,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black26,
                    Colors.black87,
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                movie.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              /*
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 300),
                builder: (BuildContext context, double value, Widget? child) {
                  value = value.clamp(0.0, 1.0);
                  return Transform.scale(
                    scale: 1 + value,
                    child: Opacity(
                      opacity: 1 - value,
                      child: Text(
                        movie.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              */
            ),
          ],
        ),
      ),
    );
  }
}
