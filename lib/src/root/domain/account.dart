import 'package:json_annotation/json_annotation.dart';
part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountDetails {
  String phoneNumber;
  String emailId;

  AccountDetails({required this.emailId, required this.phoneNumber});
  factory AccountDetails.fromJson(Map<String, dynamic> json) => _$AccountDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDetailsToJson(this);
}

@JsonSerializable()
class AccountVehicle {
  final String vin;
  final String vehicleName;
  final String year;
  final String make;
  final String model;
  AccountVehicle({
    required this.make,
    required this.model,
    required this.vehicleName,
    required this.vin,
    required this.year,
  });
  factory AccountVehicle.fromJson(Map<String, dynamic> json) => _$AccountVehicleFromJson(json);
  Map<String, dynamic> toJson() => _$AccountVehicleToJson(this);
}
