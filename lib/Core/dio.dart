import 'package:dio/dio.dart';

class DioHelper {
  final dio = Dio();
  Future<Response> post(String url, Map<String, String> body, String token,
      Map<String, String>? headers) async {
    var response = await dio.post(
      url,
      data: body,
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: headers ?? {'Authorization': "Bearer $token"}),
    );
    return response;
  }
}
