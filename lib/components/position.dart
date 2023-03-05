import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'functions.dart';

class GetPosition {
  static Position _position = Position(
      longitude: 31.225180,
      latitude: 29.368972,
      timestamp: DateTime(2023),
      accuracy: 1.0,
      altitude: 100.0,
      heading: 0.0,
      speed: 00.0,
      speedAccuracy: 0.0);
  GetPosition(bool firstTime) {
    if (firstTime) {
      _get();
    }
  }
  static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast('Location services are disabled. Please enable the services',
          TOAST_STATUS.TOAST_FAILED);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast('Location permissions are denied', TOAST_STATUS.TOAST_FAILED);

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast('Location permissions are denied', TOAST_STATUS.TOAST_FAILED);
      return false;
    }
    return true;
  }

  Future<void> _get() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Position get() {
    return _position;
  }
}
