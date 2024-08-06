import 'package:danlaw_charger/src/constants/keys.dart';
import 'package:danlaw_charger/src/features/household/domain/pricing_method.dart';
import 'package:danlaw_charger/src/features/vehicle/domain/vehicle.dart';
import 'package:danlaw_charger/src/utils/vin_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:danlaw_charger/src/api/mock_api.dart';
import 'package:world_zipcode_validator/world_zipcode_validator.dart';
import 'package:us_states/us_states.dart';
import 'package:country_code/country_code.dart';
import 'package:uuid/uuid.dart';

void main() {
  setUpAll(() => WidgetsFlutterBinding.ensureInitialized());

  bool isValidPhoneNumber(String? value) =>
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');
  bool isValidEmail(String? value) => RegExp(r'[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+ ').hasMatch(value ?? '');
  DateTime convertUnixSeconds(String seconds) => DateTime.fromMillisecondsSinceEpoch(int.parse(seconds) * 1000);

  test('get_household_list', () async {
    final response = await APIMock().getHouseholds();
    if (response.length > 1) {
      expect(WorldZipcodeValidator.isValid('us', response[0].homeAddress.zipCode), true);
      expect(USStates.getAllAbbreviations().contains(response[0].homeAddress.state), true);
      expect(PricingMethodType.values.map((e) => e.name).toList().contains(response[0].chargePricingMethod!.type.name),
          true);
    }
    if (response.length > 2) {
      expect(WorldZipcodeValidator.isValid('us', response[1].homeAddress.zipCode), true);
      expect(USStates.getAllAbbreviations().contains(response[1].homeAddress.state), true);
      expect(PricingMethodType.values.map((e) => e.name).toList().contains(response[1].chargePricingMethod!.type.name),
          true);
    }
  });
  test('get_countries', () async {
    final response = await APIMock().getCountries();
    if (response.length > 1) {
      expect(CountryCode.values.map((e) => e.alpha2).toList().contains(response[0].code), true);
    }
    if (response.length > 2) {
      expect(CountryCode.values.map((e) => e.alpha2).toList().contains(response[1].code), true);
    }
  });
  test('account_details', () async {
    final response = await APIMock().getAccountDetails();
    if ((response.households?.length ?? 0) > 1) {
      expect(Uuid.isValidUUID(fromString: response.households![0].householdId), true);
      expect(isValidPhoneNumber(response.phoneNumber), true);
      expect(isValidEmail(response.emailId), true);
    }
    if ((response.vehicles?.length ?? 0) > 1) {
      expect(isValidVIN(response.vehicles![0].vin), true, reason: Keys.invalidVIN);
    }
    if ((response.vehicles?.length ?? 0) > 2) {
      expect(isValidVIN(response.vehicles![1].vin), true, reason: Keys.invalidVIN);
    }
    if ((response.vehicles?.length ?? 0) > 3) {
      expect(isValidVIN(response.vehicles![2].vin), true, reason: Keys.invalidVIN);
    }
    if ((response.households?.length ?? 0) > 2) {
      expect(Uuid.isValidUUID(fromString: response.households![1].householdId), true);
    }
    if ((response.households?.length ?? 0) > 3) {
      expect(Uuid.isValidUUID(fromString: response.households![2].householdId), true);
    }
  });

  /// max 6 vehicles
  test('vehicles_for_household', () async {
    final response = await APIMock().getVehiclesForHousehold();
    if (response.length > 1) {
      expect(int.parse(response[0].range) >= 0, true);
      expect(isValidVIN(response[0].vin), true, reason: Keys.invalidVIN);
      expect((int.parse(response[0].battery)) >= 0, true, reason: Keys.negativeRange);
      expect(VehicleHealth.values.map((e) => e.name).toList().contains(response[0].vehicleHealth.name), true);
      expect(VehicleRangeStatus.values.map((e) => e.name).toList().contains(response[0].vehicleStatus.name), true);
    }
    if (response.length > 2) {
      expect(int.parse(response[1].range) >= 0, true);
      expect(isValidVIN(response[1].vin), true, reason: Keys.invalidVIN);
      expect((int.parse(response[1].battery)) >= 0, true, reason: Keys.negativeRange);
      expect(VehicleHealth.values.map((e) => e.name).toList().contains(response[1].vehicleHealth.name), true);
      expect(VehicleRangeStatus.values.map((e) => e.name).toList().contains(response[1].vehicleStatus.name), true);
    }
    if (response.length > 3) {
      expect(int.parse(response[0].range) >= 0, true);
      expect(isValidVIN(response[2].vin), true, reason: Keys.invalidVIN);
      expect((int.parse(response[2].battery)) >= 0, true, reason: Keys.negativeRange);
      expect(VehicleHealth.values.map((e) => e.name).toList().contains(response[2].vehicleHealth.name), true);
      expect(VehicleRangeStatus.values.map((e) => e.name).toList().contains(response[2].vehicleStatus.name), true);
    }
    if (response.length > 4) {
      expect(int.parse(response[3].range) >= 0, true);
      expect(isValidVIN(response[3].vin), true, reason: Keys.invalidVIN);
      expect((int.parse(response[3].battery)) >= 0, true, reason: Keys.negativeRange);
      expect(VehicleHealth.values.map((e) => e.name).toList().contains(response[3].vehicleHealth.name), true);
      expect(VehicleRangeStatus.values.map((e) => e.name).toList().contains(response[3].vehicleStatus.name), true);
    }
    if (response.length > 5) {
      expect(int.parse(response[0].range) >= 0, true);
      expect(isValidVIN(response[4].vin), true, reason: Keys.invalidVIN);
      expect((int.parse(response[4].battery)) >= 0, true, reason: Keys.negativeRange);
      expect(VehicleHealth.values.map((e) => e.name).toList().contains(response[4].vehicleHealth.name), true);
      expect(VehicleRangeStatus.values.map((e) => e.name).toList().contains(response[4].vehicleStatus.name), true);
    }
    if (response.length > 6) {
      expect(int.parse(response[0].range) >= 0, true);
      expect(isValidVIN(response[5].vin), true, reason: Keys.invalidVIN);
      expect((int.parse(response[5].battery)) >= 0, true, reason: Keys.negativeRange);
      expect(VehicleHealth.values.map((e) => e.name).toList().contains(response[5].vehicleHealth.name), true);
      expect(VehicleRangeStatus.values.map((e) => e.name).toList().contains(response[5].vehicleStatus.name), true);
    }
  });

  /// max 3 chargers
  test('chargers_for_household', () async {
    final response = await APIMock().getChargerForHousehold();
    if (response.length > 1) {
      expect((response[0].chargerDetails?.chargerRate?.value ?? 0) > 0, true);
      expect(
          DateTime.now()
              .difference(convertUnixSeconds(response[0].chargerDetails?.estimatedCompleteBy ?? '0'))
              .isNegative,
          false);
    }
    if (response.length > 2) {
      if (response[1].chargerDetails?.chargerRate?.value != null) {
        expect(response[1].chargerDetails!.chargerRate!.value > 0, true);
      }
      expect(
          DateTime.now()
              .difference(convertUnixSeconds(response[1].chargerDetails?.estimatedCompleteBy ?? '0'))
              .isNegative,
          false);
    }
    if (response.length > 3) {
      if (response[2].chargerDetails?.chargerRate?.value != null) {
        expect(response[2].chargerDetails!.chargerRate!.value > 0, true);
      }
      expect(
          DateTime.now()
              .difference(convertUnixSeconds(response[2].chargerDetails?.estimatedCompleteBy ?? '0'))
              .isNegative,
          false);
    }
  });
}
