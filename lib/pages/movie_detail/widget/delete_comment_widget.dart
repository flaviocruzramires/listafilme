import 'package:flutter/material.dart';
import 'package:listafilmes/data/models/movie_comment.dart';
import 'package:listafilmes/pages/movie_detail/movie_detail_controller.dart';

//typedef OnDeletedCallback = Future<void> Function();

class DeleteCommentWidget extends StatefulWidget {
  const DeleteCommentWidget(
      {super.key, required this.comment, required this.controller});

  //final OnDeletedCallback onDeleted;

  final MovieDetailController controller;
  final MovieComment comment;

  @override
  State<DeleteCommentWidget> createState() => _DeleteCommentWidgetState();
}

class _DeleteCommentWidgetState extends State<DeleteCommentWidget> {
  bool iswainting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {}, // async => controller.deleteComment(comment.id),
          child: const Text('Excluir'),
        )
      ],
      title: const Text('Excluir comentário'),
    );
  }
}
