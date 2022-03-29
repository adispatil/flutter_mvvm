import 'package:json_annotation/json_annotation.dart';

import '../base_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'fullName')
  String? fullName;
  @JsonKey(name: 'profilePhoto')
  String? profilePhoto;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'deviceId')
  String? deviceId;

  UserDataResponse(this.userId, this.fullName, this.profilePhoto,
      this.phoneNumber, this.deviceId);

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'data')
  UserDataResponse? userDataResponse;

  AuthenticationResponse(this.userDataResponse);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
