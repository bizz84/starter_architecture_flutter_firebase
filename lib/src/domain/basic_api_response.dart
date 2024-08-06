import 'package:json_annotation/json_annotation.dart';
part 'basic_api_response.g.dart';

@JsonSerializable()
class APIResponse {

  factory APIResponse.failed() =>  APIResponse(message: "Failed", status: "500");
  factory APIResponse.success() =>  APIResponse(message: "Success", status: "200");

  final String message;
  final dynamic status;
  APIResponse({required this.message, required this.status});
  factory APIResponse.fromJson(Map<String, dynamic> json) => _$APIResponseFromJson(json);
  Map<String, dynamic> toJson() => _$APIResponseToJson(this);

}
