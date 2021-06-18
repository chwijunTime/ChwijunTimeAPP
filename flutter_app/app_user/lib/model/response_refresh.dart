import 'package:json_annotation/json_annotation.dart';

part 'response_refresh.g.dart';

@JsonSerializable()
class ResponseRefresh {
  int code;
  RefreshData data;
  String msg;
  bool success;


  ResponseRefresh({this.code, this.data, this.msg, this.success});

  factory ResponseRefresh.fromJson(Map<String, dynamic> json) => _$ResponseRefreshFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRefreshToJson(this);
}

@JsonSerializable()
class RefreshData {
  @JsonKey(name: "newToken")
  String token;

  RefreshData({this.token});

  factory RefreshData.fromJson(Map<String, dynamic> json) => _$RefreshDataFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshDataToJson(this);
}