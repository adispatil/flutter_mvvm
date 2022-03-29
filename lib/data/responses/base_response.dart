import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'message')
  String? message;
}