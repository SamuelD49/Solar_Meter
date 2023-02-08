import '/services/constants.dart';
import 'package:dio/dio.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class API {
  static Dio _dio = Dio();
  static Future<Map<String, dynamic>> loginUser(
      {String username = "", String password = ""}) async {
    try {
      final res = await _dio.post("$SERVER_URL/auth/login",
          data: {"username": username, "password": password});
      return {"success": true, "payload": res};
    } on DioError catch (e) {
      return {"success": false, "payload": e.response};
    }
  }

  static Future<Map<String, dynamic>> refreshToken(
      {String token = "", refreshToken = ""}) async {
    try {
      final res = await _dio.post("$SERVER_URL/auth/token",
          data: {"refreshToken": refreshToken},
          options: Options(headers: {"authorization": "Bearer  $token"}));
      return {"success": true, "payload": res};
    } on DioError catch (e) {
      return {"success": false, "payload": e.response};
    }
  }

  static Future<Map<String, dynamic>> getChData(
      {String token = "",
      keys = "",
      limit = 100,
      startTs = 0,
      endTs = 0}) async {
    try {
      if (endTs == 0)
        endTs = (DateTime.now().microsecondsSinceEpoch / 1000).toInt();
      final res = await _dio.get(
          "$SERVER_URL/plugins/telemetry/DEVICE/2824ca10-bf50-11ea-a54d-5ffaa438b44c/values/timeseries?keys=$keys&startTs=$startTs&endTs=$endTs&limit=$limit",
          options: Options(headers: {"authorization": "Bearer  $token"}));
      return {"success": true, "payload": res};
    } on DioError catch (e) {
      return {"success": false, "payload": e.response};
    }
  }
}
