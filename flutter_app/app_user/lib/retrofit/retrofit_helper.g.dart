// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_helper.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RetrofitHelper implements RetrofitHelper {
  _RetrofitHelper(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://13.209.85.107:8080/';
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
  Future<ResponseData> postEmailCheck(email) async {
    ArgumentError.checkNotNull(email, 'email');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'email': email};
    final _data = <String, dynamic>{};
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
  Future<ResponseNotice> getNoticeList(token) async {
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
    final value = ResponseNotice.fromJson(_result.data);
    return value;
  }
}
