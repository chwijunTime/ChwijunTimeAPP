import 'package:app_user/model/response.dart';
import 'package:app_user/model/response_login.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:app_user/model/response.dart';

part 'retrofit_helper.g.dart';

@RestApi(baseUrl: "")
abstract class RetrofitHelper {
  factory RetrofitHelper(Dio dio, {String baseUrl}) = _RetrofitHelper;

  @POST("/join")
  Future<Response1> postJoin(
      @Body() Map<String, dynamic> body
      );

  @POST("/login")
  Future<ResponseLogin> postLogin(
      @Body() Map<String, dynamic> body
      );
}