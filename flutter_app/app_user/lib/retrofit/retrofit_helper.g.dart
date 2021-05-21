// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_helper.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RetrofitHelper implements RetrofitHelper {
  _RetrofitHelper(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://52.78.120.111:8080/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseData> postJoin(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/join',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseLogin> postLogin(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseLogin.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postEmailCheck(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/email-check',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postLogout() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/v1/logout',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postRefreshToken(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/auth/refresh',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseFindPW> getCheckFindPw(classNumber, email) async {
    ArgumentError.checkNotNull(classNumber, 'classNumber');
    ArgumentError.checkNotNull(email, 'email');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'classNumber': classNumber,
      r'userEmail': email
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/v1/check/findPw',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseFindPW.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postSendEmail(email) async {
    ArgumentError.checkNotNull(email, 'email');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userEmail': email};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/check/findPw/sendEmail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> putChengPassword(token, body) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/password-change',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postProfile(tokey, body) async {
    ArgumentError.checkNotNull(tokey, 'tokey');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': tokey},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseTagList> getTagList(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/v1/tag',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseTagList.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postTag(token, body) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/tag',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseTag> getTag(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/v1/tag/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseTag.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseTag> putTag(token, index, body) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/tag/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseTag.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> deleteTag(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/v1/tag/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseContractingList> getContList(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/contracting-company',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseContractingList.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postCont(token, vo) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(vo, 'vo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(vo ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/contracting-company',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseContracting> getCont(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/contracting-company/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseContracting.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> deleteCont(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/contracting-company/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseReviewList> getReviewList(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/companyreview',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseReviewList.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postReview(token, body) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/companyreview',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseReview> getReview(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/companyreview/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseReview.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> deleteReview(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/companyreview/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseNoticeList> getNoticeList(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/v1/notice',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseNoticeList.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postNotice(token, noticeSaveDto) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(noticeSaveDto, 'noticeSaveDto');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(noticeSaveDto ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v1/notice',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseNotice> getNotice(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/notice/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseNotice.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> putNotice({token, index, noticeSaveDto}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(noticeSaveDto ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/notice/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> deleteNotice({token, index}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/notice/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseCompNoticeList> getCompList(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-announcement',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseCompNoticeList.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postComp(token, employmentAnnouncementSaveDto) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(
        employmentAnnouncementSaveDto, 'employmentAnnouncementSaveDto');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(employmentAnnouncementSaveDto ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-announcement',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseNoticeComp> getComp(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-announcement/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseNoticeComp.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> putComp(
      token, index, employmentAnnouncementSaveDto) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    ArgumentError.checkNotNull(
        employmentAnnouncementSaveDto, 'employmentAnnouncementSaveDto');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(employmentAnnouncementSaveDto ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-announcement/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> deleteComp(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-announcement/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseConfirmationList> getConfList(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-confirmation',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseConfirmationList.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> postConf(token, employmentConfirmationIdx) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(
        employmentConfirmationIdx, 'employmentConfirmationIdx');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(employmentConfirmationIdx ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-confirmation',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseConfirmation> getConf(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-confirmation/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseConfirmation.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> putConf(token, index, employmentConfirmationIdx) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    ArgumentError.checkNotNull(
        employmentConfirmationIdx, 'employmentConfirmationIdx');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(employmentConfirmationIdx ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-confirmation/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> deleteConf(token, index) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/employment-confirmation/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }
}
