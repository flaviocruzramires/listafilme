import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, Response? response)
      : super(requestOptions: r);

  @override
  String toString() {
    if (response != null) {
      return response!.data['errors'].value.first[0];
    }

    return 'Requisição inválida';
  }
}

class InternalServerError extends DioException {
  InternalServerError(RequestOptions r, Response? response)
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Erro interno no Servidor.';
  }
}
