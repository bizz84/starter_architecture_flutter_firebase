import 'package:json_annotation/json_annotation.dart';
part 'bluetooth_response.g.dart';

@JsonSerializable()
class BluetoothReponse {
  final String message;
  final String status;
  BluetoothReponse({required this.message, required this.status});
  factory BluetoothReponse.fromJson(Map<String, dynamic> json) => _$BluetoothReponseFromJson(json);
  Map<String, dynamic> toJson() => _$BluetoothReponseToJson(this);
}
