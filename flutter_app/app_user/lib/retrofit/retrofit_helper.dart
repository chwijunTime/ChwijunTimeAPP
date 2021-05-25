import 'package:app_user/model/comp_notice/response_comp_notice.dart';
import 'package:app_user/model/comp_notice/response_comp_notice_list.dart';
import 'package:app_user/model/comp_notice/response_comp_status_detail.dart';
import 'package:app_user/model/comp_notice/response_comp_status_list.dart';
import 'package:app_user/model/company_review/response_review.dart';
import 'package:app_user/model/company_review/response_review_list.dart';
import 'package:app_user/model/confirmation/response_comfirmation_list.dart';
import 'package:app_user/model/confirmation/response_confirmation.dart';
import 'package:app_user/model/consulting/response_consulting_user_list.dart';
import 'package:app_user/model/consulting/response_consulting_admin_list.dart';
import 'package:app_user/model/consulting/response_consulting_admin.dart';
import 'package:app_user/model/contracting_company/response_contracting.dart';
import 'package:app_user/model/contracting_company/response_contracting_list.dart';
import 'package:app_user/model/correction/response_corrected_list.dart';
import 'package:app_user/model/correction/response_correction.dart';
import 'package:app_user/model/correction/response_correction_list.dart';
import 'package:app_user/model/notice/response_notice.dart';
import 'package:app_user/model/notice/response_notice_list.dart';
import 'package:app_user/model/response_data.dart';
import 'package:app_user/model/response_find_pw.dart';
import 'package:app_user/model/response_login.dart';
import 'package:app_user/model/resume_portfolio/response_portfolio.dart';
import 'package:app_user/model/resume_portfolio/response_portfolio_list.dart';
import 'package:app_user/model/resume_portfolio/response_resume_list.dart';
import 'package:app_user/model/tag/response_tag.dart';
import 'package:app_user/model/tag/response_tag_list.dart';
import 'package:app_user/model/tip/response_tip.dart';
import 'package:app_user/model/tip/response_tip_list.dart';
import 'package:app_user/model/user/response_profile.dart';
import 'package:app_user/model/user/response_userinfo.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_helper.g.dart';

@RestApi(baseUrl: "http://10.120.71.242:8082/")
abstract class RetrofitHelper {
  factory RetrofitHelper(Dio dio, {String baseUrl}) = _RetrofitHelper;

  //region 1. 회원
  @POST("/v1/join")
  Future<ResponseData> postJoin(@Body() Map<String, dynamic> body);

  @POST("/v1/login")
  Future<ResponseLogin> postLogin(@Body() Map<String, dynamic> body);

  @POST("/v1/email-check")
  Future<ResponseData> postEmailCheck(@Body() Map<String, dynamic> body);

  @POST("/v1/logout")
  Future<ResponseData> postLogout();

  @POST("/v1/auth/refresh")
  Future<ResponseData> postRefreshToken(@Body() Map<String, dynamic> body);

  @GET("/v1/check/findPw")
  Future<ResponseFindPW> getCheckFindPw(
      @Query("classNumber", encoded: true) String classNumber,
      @Query("userEmail", encoded: true) String email);

  @POST("/v1/check/findPw/sendEmail")
  Future<ResponseData> postSendEmail(
      @Query("userEmail", encoded: true) String email);

  @PUT("/v1/password-change")
  Future<ResponseData> putChengPassword(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @POST("/v1/profile")
  Future<ResponseData> postProfile(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @PUT("/v1/update-profile")
  Future<ResponseData> putProfile(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @GET("/v1/userinfo")
  Future<ResponseUserInfo> getUserInfo(
    @Header("Authorization") String token,
  );

  @GET("/v1/view-profile")
  Future<ResponseProfile> getProfile(
    @Header("Authorization") String token,
  );

  //endregion

  //region 2. 면접 후기 및 회사 후기
  @GET("/v1/companyreview")
  Future<ResponseReviewList> getReviewList(
      @Header("Authorization") String token);

  @POST("/v1/companyreview")
  Future<ResponseData> postReview(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @GET("/v1/companyreview-keyword")
  Future<ResponseReviewList> getReviewListKeyword(
      @Header("Authorization") String token,
      @Query("companyNameKeyword", encoded: true) String keyword);

  @GET("/v1/companyreview/{companyreviewIdx}")
  Future<ResponseReview> getReview(@Header("Authorization") String token,
      @Path("companyreviewIdx") int index);

  @PUT("/v1/companyreview/{companyreviewIdx}")
  Future<ResponseData> putReview(@Header("Authorization") String token,
      @Path("companyreviewIdx") int index, @Body() Map<String, dynamic> body);

  @DELETE("/v1/companyreview/{companyreviewIdx}")
  Future<ResponseData> deleteReview(@Header("Authorization") String token,
      @Path("companyreviewIdx") int index);

  //endregion

  //region 3. 협약 업체
  @GET("/v1/contracting-company")
  Future<ResponseContractingList> getContList(
    @Header("Authorization") String token,
  );

  @POST("/v1/contracting-company")
  Future<ResponseData> postCont(
      @Header("Authorization") String token, @Body() Map<String, dynamic> vo);

  @GET("/v1/contracting-company-keyword")
  Future<ResponseContractingList> getContListKeyword(
      @Header("Authorization") String token,
      @Query("keyword", encoded: true) String keyword);

  @GET("/v1/contracting-company/{companyidx}")
  Future<ResponseContracting> getCont(
      @Header("Authorization") String token, @Path("companyidx") int index);

  @PUT("/v1/contracting-company/{companyidx}")
  Future<ResponseData> putCont(@Header("Authorization") String token,
      @Path("companyidx") int index, @Body() Map<String, dynamic> body);

  @DELETE("/v1/contracting-company/{companyidx}")
  Future<ResponseData> deleteCont(
      @Header("Authorization") String token, @Path("companyidx") int index);

  //endregion

  //region 4. 취업 공고
  @POST("/v1/application-accept/{applicationIdx}")
  Future<ResponseData> postCompNoticeAcc(
      @Header("Authorization") String token, @Path("applicationIdx") int index);

  @POST("/v1/application-reject/{applicationIdx}")
  Future<ResponseData> postCompNoticeRej(
      @Header("Authorization") String token, @Path("applicationIdx") int index);

  @GET("/v1/application-keyword")
  Future<ResponseCompNoticeList> getCompListKeyword(
      @Header("Authorization") String token,
      @Query("keyword", encoded: true) String keyword);

  @GET("/v1/application-status")
  Future<ResponseCompStatusList> getCompApplyStatusList(
      @Header("Authorization") String token,
      @Query("status", encoded: true) String status);

  @GET("/v1/application/{applicationIdx}")
  Future<ResponseCompStatusDetail> getCompApplyStatus(
      @Header("Authorization") String token, @Path("applicationIdx") int index);

  @POST("/v1/application/{employmentAnnouncementIdx}")
  Future<ResponseData> postCompApply(
    @Header("Authorization") String token,
    @Path("employmentAnnouncementIdx") int index,
    @Body() Map<String, dynamic> body,
  );

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

  //endregion

  //region 5. 취업 확정 현황
  @GET("/v1/employment-confirmation")
  Future<ResponseConfirmationList> getConfList(
      @Header("Authorization") String token);

  @POST("/v1/employment-confirmation")
  Future<ResponseData> postConf(@Header("Authorization") String token,
      @Body() Map<String, dynamic> employmentConfirmationIdx);

  @GET("/v1/employment-confirmation-keyword")
  Future<ResponseConfirmationList> getConfListKeyword(
      @Header("Authorization") String token,
      @Query("keyword", encoded: true) String keyword);

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

//endregion

  //region 6. 공지사항
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

  // endregion

  //region 7. 태그
  @GET("/v1/request-tag")
  Future<ResponseTagList> getReqTagList(@Header("Authorization") String token);

  @POST("/v1/request-tag")
  Future<ResponseData> postReqTag(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @GET("/v1/request-tag/{rtagidx}")
  Future<ResponseTag> getReqTag(
      @Header("Authorization") String token, @Path("rtagidx") int index);

  @DELETE("/v1/request-tag/{rtagidx}")
  Future<ResponseData> deleteReqTag(
      @Header("Authorization") String token, @Path("rtagidx") int index);

  @GET("/v1/tag")
  Future<ResponseTagList> getTagList(@Header("Authorization") String token);

  @POST("/v1/tag")
  Future<ResponseData> postTag(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @GET("/v1/tag/{tagIdx}")
  Future<ResponseTag> getTag(
      @Header("Authorization") String token, @Path("tagIdx") int index);

  @PUT("/v1/tag/{tagIdx}")
  Future<ResponseTag> putTag(@Header("Authorization") String token,
      @Path("tagIdx") int index, @Body() Map<String, dynamic> body);

  @DELETE("/v1/tag/{tagIdx}")
  Future<ResponseData> deleteTag(
    @Header("Authorization") String token,
    @Path("tagIdx") int index,
  );

//endregion

  //region 8. 이력서 및 포트폴리오
  @GET("/v1/my-portfolio")
  Future<ResponsePortfolioList> getMyPortfolioList(
      @Header("Authorization") String token);

  @GET("/v1/my-resume")
  Future<ResponseResumeList> getMyResumeList(
      @Header("Authorization") String token);

  @GET("/v1/portfolio")
  Future<ResponsePortfolioList> getPortfolioList(
      @Header("Authorization") String token);

  @POST("/v1/portfolio")
  Future<ResponseData> postPortfolio(@Header("Authorization") String token,
      @Body() Map<String, dynamic> body // TODO "notionPortfolioURL": "string"
      );

  @GET("/v1/portfolio/{portfolioIdx}")
  Future<ResponsePortfolio> getPortfolio(
      @Header("Authorization") String token, @Path("portfolioIdx") int index);

  @PUT("/v1/portfolio/{portfolioIdx}")
  Future<ResponseData> putPortfolio(
      @Header("Authorization") String token,
      @Path("portfolioIdx") int index,
      @Body() Map<String, dynamic> body // TODO "notionPortfolioURL": "string"
      );

  @DELETE("/v1/portfolio/{portfolioIdx}")
  Future<ResponseData> deletePortfolio(
      @Header("Authorization") String token, @Path("portfolioIdx") int index);

  @GET("/v1/resume")
  Future<ResponseResumeList> getResumeList(
      @Header("Authorization") String token);

  @POST("/v1/portfolio")
  Future<ResponseData> postResume(@Header("Authorization") String token,
      @Body() Map<String, dynamic> body // TODO "resumeFileURL": "string"
      );

  @GET("/v1/portfolio/{resumeIdx}")
  Future<ResponsePortfolio> getResume(
      @Header("Authorization") String token, @Path("resumeIdx") int index);

  @PUT("/v1/portfolio/{resumeIdx}")
  Future<ResponseData> putResume(
      @Header("Authorization") String token,
      @Path("resumeIdx") int index,
      @Body() Map<String, dynamic> body // TODO "resumeFileURL": "string"
      );

  @DELETE("/v1/portfolio/{resumeIdx}")
  Future<ResponseData> deleteResume(
      @Header("Authorization") String token, @Path("resumeIdx") int index);

//endregion

  //region 9. 이력서 및 포트폴리오 첨삭
  @GET("/v1/correction")
  Future<ResponseCorrectionList> getCorrectionList(
    @Header("Authorization") String token,
  );

  @POST("/v1/correction-approval")
  Future<ResponseData> postCorrectionApproval(
      @Header("Authorization") String token,
      @Body() Map<String, dynamic> body,
      @Query("idx", encoded: true) int index);

  @POST("/v1/correction-rejection")
  Future<ResponseData> postCorrectionReject(
      @Header("Authorization") String token,
      @Body() Map<String, dynamic> body,
      @Query("idx", encoded: true) int index);

  @POST("/v1/correction-request")
  Future<ResponseData> postCorrectionRequest(
      @Header("Authorization") String token,
      @Query("correctionType", encoded: true) String type,
      @Query("idx", encoded: true) int index);

  @GET("/v1/correction/{idx}")
  Future<ResponseCorrection> getCorrection(
    @Header("Authorization") String token,
    @Path("idx") int type,
  );

  @GET("/v1/my-correction")
  Future<ResponseCorrectionList> getMyCorrectionList(
    @Header("Authorization") String token,
  );

  //endregion

  //region 10. 상담
  @GET("/v1/consulting-admin")
  Future<ResponseConsultingAdminList> getConsultingAdminList(
    @Header("Authorization") String token,
  );

  @GET("/v1/consulting-admin")
  Future<ResponseData> postConsultingAdmin(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> body, // TODO  "applicationDate": "string"
  );

  @GET("/v1/consulting-admin/{consultingIdx}")
  Future<ResponseConsultingAdmin> getConsultingAdmin(
      @Header("Authorization") String token, @Path("consultingIdx") int index);

  @DELETE("/v1/consulting-admin/{consultingIdx}")
  Future<ResponseData> deleteConsulting(
      @Header("Authorization") String token, @Path("consultingIdx") int index);

  @GET("/v1/consulting-user")
  Future<ResponseConsultingUserList> getConsultingUserList(
    @Header("Authorization") String token,
  );

  @GET("/v1/consulting-user")
  Future<ResponseData> postConsultingUser(
      @Header("Authorization") String token,
      @Query("idx", encoded: true) int index,
      @Body() Map<String, dynamic> body);

// endregion

  //region 11. 마이페이지
  @GET("/v1/mypage-application-employment")
  Future<ResponseCompStatusList> getMyApplyCompNotice(
    @Header("Authorization") String token,
  );

  @GET("/v1/mypage-company-review")
  Future<ResponseReviewList> getMyReview(
    @Header("Authorization") String token,
  );

  @GET("/v1/mypage-consulting-user")
  Future<ResponseConsultingUserList> getMyConsulting(
    @Header("Authorization") String token,
  );

  @GET("/v1/mypage-correction")
  Future<ResponseCorrectedList> getMyCorrection(
    @Header("Authorization") String token,
  );

  @GET("/v1/mypage-correction-apply")
  Future<ResponseCorrectionList> getMyCorrectionApply(
    @Header("Authorization") String token,
  );

  @GET("/v1/mypage-portfolio")
  Future<ResponsePortfolioList> getMyPortfolio(
    @Header("Authorization") String token,
  );

  @GET("/v1/mypage-resume")
  Future<ResponseResumeList> getMyResume(
    @Header("Authorization") String token,
  );

  @GET("/v1/mypage-tip-user")
  Future<ResponseTipList> getMyTip(
    @Header("Authorization") String token,
  );

  //endregion

  //region 12. 꿀팁
  @GET("/v1/tips-storage")
  Future<ResponseTipList> getTipList(
    @Header("Authorization") String token,
  );

  @POST("/v1/tips-storage")
  Future<ResponseData> postTip(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> body, // TipVO를 이용
  );

  @GET("/v1/tips-storage-keyword")
  Future<ResponseTipList> getTipListKeyword(
      @Header("Authorization") String token,
      @Query("keyword", encoded: true) String keyword);

  @GET("/v1/tips-storage/{tipidx}")
  Future<ResponseTip> getTip(
      @Header("Authorization") String token, @Path("tipidx") int idx);

  @PUT("/v1/tips-storage/{tipidx}")
  Future<ResponseData> putTip(@Header("Authorization") String token,
      @Path("tipidx") int idx, @Body() Map<String, dynamic> body);

  @DELETE("/v1/tips-storage/{tipidx}")
  Future<ResponseData> deleteTip(
      @Header("Authorization") String token, @Path("tipidx") int idx);

//endregion
}
