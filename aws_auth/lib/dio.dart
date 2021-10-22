import 'package:aws_auth/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();
Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = 'http://192.168.42.75:8000/api/';

  dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) async {
    request.headers['Accept'] = 'application/json';
    var token = await storage.read(key: 'token');

    if (token.toString().isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(request);
  }));
  return dio;
}
