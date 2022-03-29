// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      json['userId'] as String?,
      json['fullName'] as String?,
      json['profilePhoto'] as String?,
      json['phoneNumber'] as String?,
      json['deviceId'] as String?,
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'profilePhoto': instance.profilePhoto,
      'phoneNumber': instance.phoneNumber,
      'deviceId': instance.deviceId,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['data'] == null
          ? null
          : UserDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..type = json['type'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'data': instance.userDataResponse,
    };
