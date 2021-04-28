import 'package:app_user/model/notice/response_notice.dart';
import 'package:app_user/model/response_data.dart';
import 'package:app_user/model/response_login.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_helper.g.dart';

@RestApi(baseUrl: "http://13.209.85.107:8080/")
abstract class RetrofitHelper {
  factory RetrofitHelper(Dio dio, {String baseUrl}) = _RetrofitHelper;

  //region 1. 회원
  @POST("/v1/join")
  Future<ResponseData> postJoin(@Body() Map<String, dynamic> body);

  @POST("/v1/login")
  Future<ResponseLogin> postLogin(@Body() Map<String, dynamic> body);

  @POST("/v1/email-check")
  Future<ResponseData> postEmailCheck(
      @Query("email", encoded: true) String email);

  //endregion

  //region 5. 공지사항
  @GET("/v1/notice")
  Future<ResponseNotice> getNoticeList(@Header("Authorization") String token);

//endregion
}
