import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constant.dart';

void showToast(String text, TOAST_STATUS toast) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: (toast == TOAST_STATUS.TOAST_SUCCESS)
          ? Colors.green.withOpacity(0.9)
          : Colors.red.withOpacity(0.9),
      textColor: textColor,
      fontSize: 16.0);
}

enum TOAST_STATUS { TOAST_SUCCESS, TOAST_FAILED }

bool validate(String? email, String? password) {
  if (email == null || password == null || email.isEmpty && password.isEmpty) {
    showToast('please make sure that email and password is correct',
        TOAST_STATUS.TOAST_FAILED);
    return false;
  } else if (!email.contains('@') && email.contains('.com')) {
    showToast(
        'please make sure that email is correct', TOAST_STATUS.TOAST_FAILED);
    return false;
  } else if (password.length <= 6) {
    showToast('please make sure that password is greater than 6 characters',
        TOAST_STATUS.TOAST_FAILED);
    return false;
  } else {
    return true;
  }
}

Future<bool> handleLocationPermission(BuildContext context) async {
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

Future<Position> get_Position() async {
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest);
}
