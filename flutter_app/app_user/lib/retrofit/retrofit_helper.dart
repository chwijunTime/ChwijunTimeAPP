import 'package:app_user/model/response_data.dart';
import 'package:app_user/model/response_login.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_helper.g.dart';

@RestApi(baseUrl: "http://ec2-3-36-120-178.ap-northeast-2.compute.amazonaws.com:8080/")
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

  @POST("/email-check")
  Future<ResponseData> postEmailCheck(
      @Query("email", encoded: true) String email
      );
}