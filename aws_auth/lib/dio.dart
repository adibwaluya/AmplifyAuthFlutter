import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = 'http://192.168.42.75:8000/api/';
  return dio;
}
