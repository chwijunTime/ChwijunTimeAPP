import 'package:app_user/model/response_data.dart';
import 'package:app_user/model/response_login.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_helper.g.dart';

@RestApi(baseUrl: "http://192.168.137.47:8080/v1")
abstract class RetrofitHelper {
  factory RetrofitHelper(Dio dio, {String baseUrl}) = _RetrofitHelper;

  @POST("/join")
  Future<ResponseData> postJoin(
      @Body() Map<String, dynamic> body
      );

  @POST("/login")
  Future<ResponseLogin> postLogin(
      @Body() Map<String, dynamic> body
      );
}