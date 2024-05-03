import 'package:dio/dio.dart';
import 'package:listafilmes/data/exception_handler.dart';

class AppInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err.response);
          case 500:
            throw InternalServerError(err.requestOptions, err.response);
        }
        break;
      default:
    }
    return handler.next(err);
  }
}
