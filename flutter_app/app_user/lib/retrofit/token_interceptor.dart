import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  Dio dio;
  String token;

  Future<Dio> init() async {
    dio = Dio();
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("accessToken");
    dio.interceptors.add(TokenInterceptor());
    return dio;
  }

  @override
  Future onRequest(RequestOptions options) async {
    options.headers["Authorization"] = token;
    return options;
  }

  @override
  Future onError(DioError err) async {
    if (err.response?.statusCode == 401) {
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();
      RequestOptions options = err.response.request;
      final pref = await SharedPreferences.getInstance();
      var refreshToken = pref.getString("refreshToken");
      print("refreshToken: $refreshToken");
      RetrofitHelper tokenHelper = RetrofitHelper(Dio());
      var res = await tokenHelper.postRefreshToken({"refreshToken": refreshToken});
      try {
        if (res.success) {
          print("newToken: ${res.data.token}");
          options.headers["Authorization"] = "Bearer " + res.data.token;
          pref.setString("accessToken", "Bearer " + res.data.token);
        } else {
          print("err: ${res.msg}");
        }
      } catch (e) {
        print("호잇: $e");
      }
      print("accessToken: ${pref.getString("accessToken")}");
      dio.interceptors.requestLock.unlock();
      dio.interceptors.responseLock.unlock();
      return dio.request(options.path, options: options);
    } else {
      return err.response.data;
    }
  }

  @override
  Future onResponse(Response response) async {
    return response;
  }
}