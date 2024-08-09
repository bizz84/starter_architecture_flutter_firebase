import 'package:equatable/equatable.dart';
import 'package:flutter_starter_base_app/src/root/domain/item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'report_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportData implements Item {
  final String label;
  final String value;

  final double x;
  final double y;

  ReportData({
    required this.label,
    required this.value,
    required this.x,
    required this.y
  });

  factory ReportData.fromJson(Map<String, dynamic> json) => _$ReportDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReportDataToJson(this);

}