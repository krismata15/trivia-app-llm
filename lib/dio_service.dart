import 'package:dio/dio.dart';

class DioService {
  static late Dio dio;

  void init(Dio externalDio) {
    dio = externalDio;
  }
}
