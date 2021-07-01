import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor {
  static Future<Dio> getApiClient(BuildContext context, VoidCallback setState) async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    Dio dio =
        Dio(BaseOptions(connectTimeout: 1000 * 10, receiveTimeout: 1000 * 10));
    Dio tokenDio = Dio();
    RetrofitHelper tokenHelper = RetrofitHelper(tokenDio);
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options) {
      options.headers["Authorization"] = token;
      print("1111");
      return options;
    }, onResponse: (response) {
      print("2222");
      return response;
    }, onError: (DioError error) async {
      if (error.response?.statusCode == 401) {
        dio.interceptors.requestLock.lock();
        dio.interceptors.responseLock.lock();
        RequestOptions options = error.response.request;
        final pref = await SharedPreferences.getInstance();
        var refreshToken = pref.getString("refreshToken");
        var res =
            await tokenHelper.postRefreshToken({"refreshToken": refreshToken});
        try {
          if (res.success) {
            options.headers["Authorization"] = "Bearer " + res.data.token;
            pref.setString("accessToken", "Bearer " + res.data.token);
            tokenDio.interceptors.requestLock.lock();
            tokenDio.interceptors.responseLock.lock();
          } else {
            Navigator.pushReplacementNamed(context, "/login");
            pref.clear();
            snackBar("자동로그인 기간이 만료되었습니다.\n다시 로그인 해주세요", context);
          }
        } catch (e) {
          print("err: $e");
        }
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
        setState.call();
        return dio.request(options.path, options: options);
      } else if (error.type == DioErrorType.DEFAULT) {
        snackBar("인터넷이 연결되지 않습니다. \n교내 와이파이에 연결후 다시 실행해주세요.", context);
      } else {
        return error.response;
      }
    }));
    return dio;
  }
}
