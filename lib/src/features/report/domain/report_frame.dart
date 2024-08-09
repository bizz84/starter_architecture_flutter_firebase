import 'package:flutter_starter_base_app/src/root/domain/item.dart';
import 'package:flutter_starter_base_app/src/root/domain/label_value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_starter_base_app/src/utils/string_extension.dart';
part 'report_frame.g.dart';

enum TimeWindowEnum { past31Days, thisWeek, thisMonth, thisYear }

@JsonSerializable(explicitToJson: true)
class TimeWindow extends LabelValuePair with Item {
  final TimeWindowEnum timeWindowEum;
  const TimeWindow({required super.value, required super.label, required this.timeWindowEum});
  String get name => value.toString().camelCaseToTitleCase();

  @override
  String get displayText => name;
  String get localizationKey => "reports.tw.${timeWindowEum.name}";
  LabelValuePair get toLabelValuePair => LabelValuePair(label: name, value: value);
  factory TimeWindow.fromLabelValuePair(LabelValuePair labelValuePair) => TimeWindow(
      value: labelValuePair.value,
      label: labelValuePair.label,
      timeWindowEum: TimeWindowEnum.values.firstWhere((e) => labelValuePair.value == e.name));
  factory TimeWindow.fromJson(String json) =>
      TimeWindow(value: json, label: json, timeWindowEum: $enumDecode(_$TimeWindowEnumEnumMap, json));

  @override
  Map<String, dynamic> toJson() => _$TimeWindowToJson(this);
  static List<TimeWindow> get values =>
      TimeWindowEnum.values.map((e) => TimeWindow(value: e.name, label: e.name, timeWindowEum: e)).toList();
}
