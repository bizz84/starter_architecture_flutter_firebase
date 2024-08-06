import 'package:equatable/equatable.dart';
import 'package:flutter_starter_base_app/src/domain/item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'label_value.g.dart';

@JsonSerializable(explicitToJson: true)
class LabelValuePair extends Equatable implements Item {
  final String label;
  final dynamic value;
  const LabelValuePair({required this.label, required this.value});
  factory LabelValuePair.fromJson(Map<String, dynamic> json) => _$LabelValuePairFromJson(json);
  Map<String, dynamic> toJson() => _$LabelValuePairToJson(this);

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  String get displayText => label;
}

