import 'package:flutter_starter_base_app/src/features/account/data/account_provider.dart';
import 'package:flutter_starter_base_app/src/features/household/domain/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FeatureType {
  household,
  charger,
  vehicle,
}

class FeatureConstraints {
  // households threshold
  final int _maxHouseholds = 6;

  //  chargers threshold
  final int _maxChargersPerHousehold = 3;

  //  vehicles threshold
  final int _maxVehiclesPerAccount = 6;

  Future<bool> canCreateFeature(WidgetRef ref,
      {required FeatureType featureType, String? householdId, bool overrideThreshold = false}) async {
    switch (featureType) {
      case FeatureType.household:
        return await _canCreateHousehold(ref, overrideThreshold);
      case FeatureType.charger:
        return await _canCreateCharger(ref, overrideThreshold, householdId: householdId);
      case FeatureType.vehicle:
        return await _canCreateVehicle(ref, overrideThreshold);
    }
  }

  Future<bool> _canCreateHousehold(WidgetRef ref, bool overrideThreshold) async {
    try {
      if (overrideThreshold) {
        return true;
      } else{
         final accountDetails = await ref.watch(fetchAccountDetailsProvider.future);
      debugPrint("Total households in the account: ${accountDetails.households?.length}");
      return (accountDetails.households?.length ?? 0) < _maxHouseholds;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    throw Exception("Failed to fetch households list to validate");
  }

  Future<bool> _canCreateCharger(WidgetRef ref, bool overrideThreshold, {String? householdId}) async {
    try {
      if (overrideThreshold) {
        return true;
      } else {
        final chargersList = await ref.watch(fetchHouseholdChargerListProvider.call(householdId: householdId ?? '').future);
        debugPrint("Total chargers in the household: ${chargersList.length}");
        return chargersList.length < _maxChargersPerHousehold;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    throw Exception("Failed to fetch chargers list to validate");
  }

  Future<bool> _canCreateVehicle(WidgetRef ref, bool overrideThreshold) async {
    try {
      if (overrideThreshold) {
        return true;
      } else {
        final accountDetails = await ref.watch(fetchAccountDetailsProvider.future);
        debugPrint("Total vehicles in the account: ${accountDetails.vehicles?.length}");
        return (accountDetails.vehicles?.length ?? 0) < _maxVehiclesPerAccount;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    throw Exception("Failed to fetch vehicles list to validate");
  }

  int getFeatureThreshold(FeatureType featureType) {
    switch (featureType) {
      case FeatureType.household:
        return _maxHouseholds;
      case FeatureType.charger:
        return _maxChargersPerHousehold;
      case FeatureType.vehicle:
        return _maxVehiclesPerAccount;
    }
  }

  Future<bool> canDeleteHousehold(WidgetRef ref, String householdId) async {
    try {
      final chargersList = await ref.watch(fetchHouseholdChargerListProvider.call(householdId: householdId).future);
        debugPrint("Total chargers in the household: ${chargersList.length}");
        return chargersList.isNotEmpty;
    } catch (e) {
      debugPrint(e.toString());
    }
    throw Exception("Failed to fetch chargers list");
  }
}
