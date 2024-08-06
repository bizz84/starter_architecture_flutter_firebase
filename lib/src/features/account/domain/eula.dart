import 'package:json_annotation/json_annotation.dart';
part 'eula.g.dart';

@JsonSerializable()
class EULA {
  final String agreementId;
  final String text;
  EULA({required this.text, required this.agreementId});
  factory EULA.fromJson(Map<String, dynamic> json) => _$EULAFromJson(json);
  Map<String, dynamic> toJson() => _$EULAToJson(this);
}
