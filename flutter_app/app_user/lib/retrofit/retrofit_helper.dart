import 'package:app_user/model/comp_notice/response_comp_notice.dart';
import 'package:app_user/model/comp_notice/response_comp_notice_list.dart';
import 'package:app_user/model/comp_notice/response_comp_status_detail.dart';
import 'package:app_user/model/comp_notice/response_comp_status_list.dart';
import 'package:app_user/model/company_review/response_review.dart';
import 'package:app_user/model/company_review/response_review_list.dart';
import 'package:app_user/model/confirmation/response_comfirmation_list.dart';
import 'package:app_user/model/confirmation/response_confirmation.dart';
import 'package:app_user/model/consulting/response_consulting_admin.dart';
import 'package:app_user/model/consulting/response_consulting_admin_list.dart';
import 'package:app_user/model/consulting/response_consulting_user_list.dart';
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
import 'package:app_user/model/response_refresh.dart';
import 'package:app_user/model/resume_portfolio/response_portfolio.dart';
import 'package:app_user/model/resume_portfolio/response_portfolio_list.dart';
import 'package:app_user/model/resume_portfolio/response_resume.dart';
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

@RestApi(baseUrl: "http://10.120.72.245:8082/4")
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
  Future<ResponseRefresh> postRefreshToken(@Body() Map<String, dynamic> body);

  @GET("/v1/check/findPw")
  Future<ResponseFindPW> getCheckFindPw(
      @Query("classNumber", encoded: true) String classNumber,
      @Query("userEmail", encoded: true) String email);

  @POST("/v1/check/findPw/sendEmail")
  Future<ResponseData> postSendEmail(
      @Query("userEmail", encoded: true) String email);

  @PUT("/v1/password-change")
  Future<ResponseData> putChengPassword(@Body() Map<String, dynamic> body);

  @POST("/v1/profile")
  Future<ResponseData> postProfile(@Body() Map<String, dynamic> body);

  @PUT("/v1/update-profile")
  Future<ResponseData> putProfile(@Body() Map<String, dynamic> body);

  @GET("/v1/userinfo")
  Future<ResponseUserInfo> getUserInfo();

  @GET("/v1/view-profile")
  Future<ResponseProfile> getProfile();

  //endregion

  //region 2. 면접 후기 및 회사 후기
  @GET("/v1/companyreview")
  Future<ResponseReviewList> getReviewList();

  @POST("/v1/companyreview")
  Future<ResponseData> postReview(@Body() Map<String, dynamic> body);

  @GET("/v1/companyreview-keyword")
  Future<ResponseReviewList> getReviewListKeyword(
      @Query("companyNameKeyword", encoded: true) String keyword);

  @GET("/v1/companyreview/{companyreviewIdx}")
  Future<ResponseReview> getReview(@Path("companyreviewIdx") int index);

  @PUT("/v1/companyreview/{companyreviewIdx}")
  Future<ResponseData> putReview(
      @Path("companyreviewIdx") int index, @Body() Map<String, dynamic> body);

  @DELETE("/v1/companyreview/{companyreviewIdx}")
  Future<ResponseData> deleteReview(@Path("companyreviewIdx") int index);

  //endregion

  //region 3. 협약 업체
  @GET("/v1/contracting-company")
  Future<ResponseContractingList> getContList();

  @POST("/v1/admin/contracting-company")
  Future<ResponseData> postCont(@Body() Map<String, dynamic> vo);

  @GET("/v1/contracting-company-keyword")
  Future<ResponseContractingList> getContListKeyword(
      @Query("keyword", encoded: true) String keyword);

  @GET("/v1/contracting-company/{companyidx}")
  Future<ResponseContracting> getCont(@Path("companyidx") int index);

  @PUT("/v1/admin/contracting-company/{companyidx}")
  Future<ResponseData> putCont(
      @Path("companyidx") int index, @Body() Map<String, dynamic> body);

  @DELETE("/v1/admin/contracting-company/{companyidx}")
  Future<ResponseData> deleteCont(@Path("companyidx") int index);

  //endregion

  //region 4. 취업 공고
  @POST("/v1/admin/application-accept/{applicationIdx}")
  Future<ResponseData> postCompNoticeAcc(@Path("applicationIdx") int index);

  @POST("/v1/admin/application-reject/{applicationIdx}")
  Future<ResponseData> postCompNoticeRej(@Path("applicationIdx") int index);

  @GET("/v1/application-keyword")
  Future<ResponseCompNoticeList> getCompListKeyword(
      @Query("keyword", encoded: true) String keyword);

  @GET("/v1/admin/application-status")
  Future<ResponseCompStatusList> getCompApplyStatusList(
      @Query("status", encoded: true) String status);

  @GET("/v1/admin/application/{applicationIdx}")
  Future<ResponseCompStatusDetail> getCompApplyStatus(
      @Path("applicationIdx") int index);

  @POST("/v1/application/{employmentAnnouncementIdx}")
  Future<ResponseData> postCompApply(
    @Path("employmentAnnouncementIdx") int index,
    @Body() Map<String, dynamic> body,
  );

  @GET("/v1/employment-announcement")
  Future<ResponseCompNoticeList> getCompList();

  @POST("/v1/admin/employment-announcement")
  Future<ResponseData> postComp(
      @Body() Map<String, dynamic> employmentAnnouncementSaveDto);

  @GET("/v1/employment-announcement/{employmentAnnouncementIdx}")
  Future<ResponseNoticeComp> getComp(
      @Path("employmentAnnouncementIdx") int index);

  @PUT("/v1/admin/employment-announcement/{employmentAnnouncementIdx}")
  Future<ResponseData> putComp(@Path("employmentAnnouncementIdx") int index,
      @Body() Map<String, dynamic> employmentAnnouncementSaveDto);

  @DELETE("/v1/admin/employment-announcement/{employmentAnnouncementIdx}")
  Future<ResponseData> deleteComp(
    @Path("employmentAnnouncementIdx") int index,
  );

  //endregion

  //region 5. 취업 확정 현황
  @GET("/v1/employment-confirmation")
  Future<ResponseConfirmationList> getConfList();

  @POST("/v1/admin/employment-confirmation")
  Future<ResponseData> postConf(
      @Body() Map<String, dynamic> employmentConfirmationIdx);

  @GET("/v1/employment-confirmation-keyword")
  Future<ResponseConfirmationList> getConfListKeyword(
      @Query("keyword", encoded: true) String keyword);

  @GET("/v1/employment-confirmation/{employmentConfirmationIdx}")
  Future<ResponseConfirmation> getConf(
    @Path("employmentConfirmationIdx") int index,
  );

  @PUT("/v1/admin/employment-confirmation/{employmentConfirmationIdx}")
  Future<ResponseData> putConf(
      @Path("employmentConfirmationIdx") int index,
      @Body() Map<String, dynamic> employmentConfirmationIdx);

  @DELETE("/v1/admin/employment-confirmation/{employmentConfirmationIdx}")
  Future<ResponseData> deleteConf(
    @Path("employmentConfirmationIdx") int index,
  );

//endregion

  //region 6. 공지사항
  @GET("/v1/notice")
  Future<ResponseNoticeList> getNoticeList();

  @POST("/v1/admin/notice")
  Future<ResponseData> postNotice(@Body() Map<String, dynamic> noticeSaveDto);

  @GET("/v1/notice/{noticeidx}")
  Future<ResponseNotice> getNotice(@Path("noticeidx") int index);

  @PUT("/v1/admin/notice/{noticeidx}")
  Future<ResponseData> putNotice(
      {@Path("noticeidx") int index,
      @Body() Map<String, dynamic> noticeSaveDto});

  @DELETE("/v1/admin/notice/{noticeidx}")
  Future<ResponseData> deleteNotice(@Path("noticeidx") int index);

  // endregion

  //region 7. 태그
  @GET("/v1/admin/request-tag")
  Future<ResponseTagList> getReqTagList();

  @POST("/v1/request-tag")
  Future<ResponseData> postReqTag(@Body() Map<String, dynamic> body);

  @GET("/v1/admin/request-tag/{rtagidx}")
  Future<ResponseTag> getReqTag(@Path("rtagidx") int index);

  @DELETE("/v1/admin/request-tag/{rtagidx}")
  Future<ResponseData> deleteReqTag(@Path("rtagidx") int index);

  @GET("/v1/tag")
  Future<ResponseTagList> getTagList();

  @POST("/v1/admin/tag")
  Future<ResponseData> postTag(@Body() Map<String, dynamic> body);

  @GET("/v1/tag/{tagIdx}")
  Future<ResponseTag> getTag(@Path("tagIdx") int index);

  @PUT("/v1/admin/tag/{tagIdx}")
  Future<ResponseTag> putTag(
      @Path("tagIdx") int index, @Body() Map<String, dynamic> body);

  @DELETE("/v1/admin/tag/{tagIdx}")
  Future<ResponseData> deleteTag(
    @Path("tagIdx") int index,
  );

//endregion

  //region 8. 이력서 및 포트폴리오
  @GET("/v1/my-portfolio")
  Future<ResponsePortfolioList> getMyPortfolioList();

  @GET("/v1/my-resume")
  Future<ResponseResumeList> getMyResumeList();

  @GET("/v1/portfolio")
  Future<ResponsePortfolioList> getPortfolioList();

  @POST("/v1/portfolio")
  Future<ResponseData> postPortfolio(
      @Body() Map<String, dynamic> body
      );

  @GET("/v1/portfolio/{portfolioIdx}")
  Future<ResponsePortfolio> getPortfolio( @Path("portfolioIdx") int index);

  @PUT("/v1/portfolio/{portfolioIdx}")
  Future<ResponseData> putPortfolio(
      @Path("portfolioIdx") int index, @Body() Map<String, dynamic> body);

  @DELETE("/v1/portfolio/{portfolioIdx}")
  Future<ResponseData> deletePortfolio(@Path("portfolioIdx") int index);

  @GET("/v1/resume")
  Future<ResponseResumeList> getResumeList();

  @POST("/v1/resume")
  Future<ResponseData> postResume( @Body() Map<String, dynamic> body);

  @GET("/v1/resume/{resumeIdx}")
  Future<ResponseResume> getResume(@Path("resumeIdx") int index);

  @PUT("/v1/resume/{resumeIdx}")
  Future<ResponseData> putResume(
      @Path("resumeIdx") int index,
      @Body() Map<String, dynamic> body
      );

  @DELETE("/v1/resume/{resumeIdx}")
  Future<ResponseData> deleteResume( @Path("resumeIdx") int index);

//endregion

  //region 9. 이력서 및 포트폴리오 첨삭
  @GET("/v1/admin/correction")
  Future<ResponseCorrectionList> getCorrectionList(
  );

  @POST("/v1/admin/correction-approval")
  Future<ResponseData> postCorrectionApproval(
      @Body() Map<String, dynamic> body,
      @Query("idx", encoded: true) int index);

  @POST("/v1/admin/correction-rejection")
  Future<ResponseData> postCorrectionReject(
      @Body() Map<String, dynamic> body,
      @Query("idx", encoded: true) int index);

  @POST("/v1/correction-request")
  Future<ResponseData> postCorrectionRequest(
      @Query("correctionType", encoded: true) String type,
      @Query("idx", encoded: true) int index);

  @GET("/v1/admin/correction/{idx}")
  Future<ResponseCorrection> getCorrection(
    @Path("idx") int index,
  );

  @GET("/v1/my-correction")
  Future<ResponseCorrectionList> getMyCorrectionList(
  );

  //endregion

  //region 10. 상담
  @GET("/v1/consulting-admin")
  Future<ResponseConsultingAdminList> getConsultingAdminList(
  );

  @POST("/v1/admin/consulting-admin")
  Future<ResponseData> postConsultingAdmin(
    @Body() Map<String, dynamic> body
  );

  @GET("/v1/consulting-admin/{consultingIdx}")
  Future<ResponseConsultingAdmin> getConsultingAdmin( @Path("consultingIdx") int index);

  @DELETE("/v1/admin/consulting-admin/{consultingIdx}")
  Future<ResponseData> deleteConsulting( @Path("consultingIdx") int index);

  @GET("/v1/admin/consulting-user")
  Future<ResponseConsultingUserList> getConsultingUserList(
  );

  @POST("/v1/consulting-user")
  Future<ResponseData> postConsultingUser(
      @Query("idx", encoded: true) int index,
      @Body() Map<String, dynamic> body);

// endregion

  //region 11. 마이페이지
  @GET("/v1/mypage-application-employment")
  Future<ResponseCompStatusList> getMyApplyCompNotice(
  );

  @GET("/v1/mypage-company-review")
  Future<ResponseReviewList> getMyReview(
  );

  @GET("/v1/mypage-consulting-user")
  Future<ResponseConsultingUserList> getMyConsulting(
  );

  @GET("/v1/mypage-correction")
  Future<ResponseCorrectedList> getMyCorrection(
  );

  @GET("/v1/mypage-correction-apply")
  Future<ResponseCorrectionList> getMyCorrectionApply(
  );

  @GET("/v1/mypage-portfolio")
  Future<ResponsePortfolioList> getMyPortfolio(
  );

  @GET("/v1/mypage-resume")
  Future<ResponseResumeList> getMyResume(
  );

  @GET("/v1/mypage-tip-user")
  Future<ResponseTipList> getMyTip(
  );

  //endregion

  //region 12. 꿀팁
  @GET("/v1/tips-storage")
  Future<ResponseTipList> getTipList(
  );

  @POST("/v1/tips-storage")
  Future<ResponseData> postTip(
    @Body() Map<String, dynamic> body, // TipVO를 이용
  );

  @GET("/v1/tips-storage-keyword")
  Future<ResponseTipList> getTipListKeyword(
      @Query("keyword", encoded: true) String keyword);

  @GET("/v1/tips-storage/{tipidx}")
  Future<ResponseTip> getTip(@Path("tipidx") int idx);

  @PUT("/v1/tips-storage/{tipidx}")
  Future<ResponseData> putTip(
      @Path("tipidx") int idx, @Body() Map<String, dynamic> body);

  @DELETE("/v1/tips-storage/{tipidx}")
  Future<ResponseData> deleteTip(@Path("tipidx") int idx);

//endregion

  //region Dev
  @GET("/v1/abdodn/check/permissions")
  Future<String> getPermission(@Query("email", encoded: true) String email);
//endregion
}
