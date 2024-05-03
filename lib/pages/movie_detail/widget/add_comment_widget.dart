import 'package:flutter/material.dart';
import 'package:listafilmes/pages/movie_detail/movie_detail_controller.dart';
import 'package:listafilmes/service_locator.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({super.key});

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final controller = getIt<MovieDetailController>();
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final commentNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Card(
          child: Container(
            color: Colors.black54,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      focusNode: commentNode,
                      controller: commentController,
                      textCapitalization: TextCapitalization.sentences,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Comentário obrigatório';
                        }
                        if (v.length < 3) {
                          return 'Comentário muito curto';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Adicione um comentário',
                        hintStyle: TextStyle(color: Colors.white),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onSubmited,
                  style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact),
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmited() {
    if (!formKey.currentState!.validate()) return;
    if (formKey.currentState!.validate()) {
      //widget.onSubmitted(commentController.text);
      controller.postComment(commentController.text).then((value) {
        exibeSucesso();
        commentNode.unfocus();
        commentController.clear();
        formKey.currentState!.reset();
      }, onError: (error) {
        exibeErro(error);
      });
    }
  }

  void exibeErro(error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error.toString()),
      ),
    );
  }

  void exibeSucesso() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        margin: EdgeInsets.all(16),
        backgroundColor: Colors.green,
        content: Text('Comentário enviado!'),
      ),
    );
  }
}
