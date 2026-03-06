import 'package:dio/dio.dart';

// Usage:
// final api = ApiUtil.instance;
// await api.get('/users');
// await api.get('/users/1');
// await api.post('/users', data: {'name': 'John'});
// await api.put('/users/1', data: {'name': 'Jane'});
// await api.delete('/users/1');

class ApiUtil {
  ApiUtil._();

  static final _instance = ApiUtil._();
  static ApiUtil get instance => _instance;

  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000'));

  Future<Response> get(String path, {Map<String, dynamic>? params}) =>
      _dio.get(path, queryParameters: params);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response> delete(String path) => _dio.delete(path);
}
