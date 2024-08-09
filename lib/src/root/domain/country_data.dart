import 'package:flutter_starter_base_app/src/root/domain/item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'country_data.g.dart';

@JsonSerializable()
class Country with Item {
  final String name;
  final String code;
  final String telephoneCode;
  Country({
    required this.code,
    required this.name,
    required this.telephoneCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  String get label => name;
  @override
  String get value => code;
}

@JsonSerializable()
class State with Item {
  final String name;
  final String code;
  State({required this.code, required this.name});

  factory State.fromJson(Map<String, dynamic> json) => _$StateFromJson(json);
  Map<String, dynamic> toJson() => _$StateToJson(this);

  @override
  String get label => name;
  @override
  String get value => code;
}
