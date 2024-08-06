
import 'package:json_annotation/json_annotation.dart';
part 'create_account.g.dart';
 
@JsonSerializable()
class CreateAccountRequest {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String languageCode;
   CreateAccountRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.languageCode,
  });
   factory CreateAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestFromJson(json);
   Map<String, dynamic> toJson() => _$CreateAccountRequestToJson(this);
}
 