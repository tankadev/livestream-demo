import 'package:dio/dio.dart';

import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/repositories/storage_repository.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class HttpClient {
  final Dio dio;
  final StorageRepository storage;

  HttpClient({required this.dio, required this.storage}) {
    _interceptor();
  }

  static String baseUrl = Environment().config!.apiURL;

  Future<dynamic> get(String url, {Map<String, dynamic>? query}) async {
    try {
      final Response response =
          await dio.get('$baseUrl/$url', queryParameters: query);
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? query}) async {
    try {
      print('$baseUrl/$url');
      print(body);
      final Response response = await dio.post('$baseUrl/$url',
          data: body ?? {}, queryParameters: query);
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(String url, {Map<String, dynamic>? body}) async {
    try {
      final Response response =
          await dio.put('$baseUrl/$url', data: body ?? {});
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(String url, {Map<String, dynamic>? body}) async {
    try {
      final Response response =
          await dio.delete('$baseUrl/$url', data: body ?? {});
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }

  _interceptor() async {
    dio.interceptors.add(
      QueuedInterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        // ----- Kiểm tra xử lí cho các API không cần TOKEN -----
        final String path = options.path.replaceAll(baseUrl, '');
        bool isCheckUrl = Constants.excludeApiURL
            .any((String v) => v.toLowerCase().contains(path));

        if (isCheckUrl) {
          return handler.next(options);
        }

        // Kiểm tra xử lí cho các API cần TOKEN
        final String? _accessToken =
            await storage.readSecure(key: Constants.accessToken);
        final String? _refreshToken =
            await storage.readSecure(key: Constants.refreshToken);
        if (_accessToken == null || _refreshToken == null) {
          final error =
              DioError(requestOptions: options, type: DioErrorType.other);
          return handler.reject(error, true);
        }
        options.headers["Authorization"] = 'Bearer $_accessToken';
        return handler.next(options);
      }, onError: (DioError e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
          // final String? _refreshToken =
          //     await storage.readSecure(key: Constants.refreshToken);
          // final options = e.response!.requestOptions;
          // dio.post(
          //     '$baseUrl/${ApiUrl.auth}/${ApiUrl.refreshToken}/?refreshToken=$_refreshToken',
          //     data: {}).then((json) async {
          //   await storage.saveAuthentication(
          //     accessToken: json.data['accessToken'],
          //     refreshToken: json.data['refreshToken'],
          //     expiresIn: json.data['expiresIn'],
          //   );
          //   options.headers["Authorization"] =
          //       'Bearer ${json.data['accessToken']}';
          // }).then((e) {
          //   //repeat
          //   dio.fetch(options).then(
          //     (r) => handler.resolve(r),
          //     onError: (e) {
          //       handler.reject(e);
          //     },
          //   );
          // });
          // return;
        }
        return handler.next(e);
      }),
    );
  }
}
