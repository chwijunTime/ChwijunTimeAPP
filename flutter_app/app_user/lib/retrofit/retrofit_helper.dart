import 'package:app_user/model/comp_notice/response_comp_notice.dart';
import 'package:app_user/model/comp_notice/response_comp_notice_list.dart';
import 'package:app_user/model/confirmation/response_comfirmation_list.dart';
import 'package:app_user/model/confirmation/response_confirmation.dart';
import 'package:app_user/model/notice/response_notice.dart';
import 'package:app_user/model/notice/response_notice_list.dart';
import 'package:app_user/model/response_data.dart';
import 'package:app_user/model/response_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_helper.g.dart';

@RestApi(baseUrl: "http://3.35.207.173:8080/")
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
  Future<ResponseNoticeList> getNoticeList(
      @Header("Authorization") String token);

  @POST("/v1/notice")
  Future<ResponseData> postNotice(@Header("Authorization") String token,
      @Body() Map<String, dynamic> noticeSaveDto);

  @GET("/v1/notice/{noticeidx}")
  Future<ResponseNotice> getNotice(
      @Header("Authorization") String token, @Path("noticeidx") int index);

  @PUT("/v1/notice/{noticeidx}")
  Future<ResponseData> putNotice(
      {@Header("Authorization") String token,
      @Path("noticeidx") int index,
      @Body() Map<String, dynamic> noticeSaveDto});

  @DELETE("/v1/notice/{noticeidx}")
  Future<ResponseData> deleteNotice(
      {@Header("Authorization") String token, @Path("noticeidx") int index});

//endregion

  //region 6. 취업공고
  @GET("/v1/employment-announcement")
  Future<ResponseCompNoticeList> getCompList(
      @Header("Authorization") String token);

  @POST("/v1/employment-announcement")
  Future<ResponseData> postComp(@Header("Authorization") String token,
      @Body() Map<String, dynamic> employmentAnnouncementSaveDto);

  @GET("/v1/employment-announcement/{employmentAnnouncementIdx}")
  Future<ResponseNoticeComp> getComp(@Header("Authorization") String token,
      @Path("employmentAnnouncementIdx") int index);

  @PUT("/v1/employment-announcement/{employmentAnnouncementIdx}")
  Future<ResponseData> putComp(
      @Header("Authorization") String token,
      @Path("employmentAnnouncementIdx") int index,
      @Body() Map<String, dynamic> employmentAnnouncementSaveDto);

  @DELETE("/v1/employment-announcement/{employmentAnnouncementIdx}")
  Future<ResponseData> deleteComp(
    @Header("Authorization") String token,
    @Path("employmentAnnouncementIdx") int index,
  );

  // endregion

  // region 10. 취업 확정 현황
  @GET("/v1/employment-confirmation")
  Future<ResponseConfirmationList> getConfList(
      @Header("Authorization") String token);

  @POST("/v1/employment-confirmation")
  Future<ResponseData> postConf(@Header("Authorization") String token,
      @Body() Map<String, dynamic> employmentConfirmationIdx);

  @GET("/v1/employment-confirmation/{employmentConfirmationIdx}")
  Future<ResponseConfirmation> getConf(
    @Header("Authorization") String token,
    @Path("employmentConfirmationIdx") int index,
  );

  @PUT("/v1/employment-confirmation/{employmentConfirmationIdx}")
  Future<ResponseData> putConf(
      @Header("Authorization") String token,
      @Path("employmentConfirmationIdx") int index,
      @Body() Map<String, dynamic> employmentConfirmationIdx);

  @DELETE("/v1/employment-confirmation/{employmentConfirmationIdx}")
  Future<ResponseData> deleteConf(
    @Header("Authorization") String token,
    @Path("employmentConfirmationIdx") int index,
  );
  // endregion
}
