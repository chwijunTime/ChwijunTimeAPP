// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_refresh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRefresh _$ResponseRefreshFromJson(Map<String, dynamic> json) {
  return ResponseRefresh(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : RefreshData.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseRefreshToJson(ResponseRefresh instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };

RefreshData _$RefreshDataFromJson(Map<String, dynamic> json) {
  return RefreshData(
    token: json['newToken'] as String,
  );
}

Map<String, dynamic> _$RefreshDataToJson(RefreshData instance) =>
    <String, dynamic>{
      'newToken': instance.token,
    };
