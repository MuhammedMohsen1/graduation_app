import 'dart:convert';
import 'dart:typed_data';

import 'package:application_gp/components/functions.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Bluetooth {
  BluetoothConnection? connection;
  List<BluetoothDevice> devices = [];
  String? information;
  BluetoothDevice? device;
  Future<void> scanDevices() async {
    try {
      devices.clear;

      await FlutterBluetoothSerial.instance.cancelDiscovery();
      FlutterBluetoothSerial.instance.startDiscovery().forEach((element) {
        devices.add(element.device);
      }).whenComplete(() {
        print('Completed');
      });
      await Future.delayed(Duration(seconds: 3));

      /* FlutterBluetoothSerial.instance.getBondedDevices().then((value) {
        devices = value;
        devices.forEach((element) {
          print('${element.name} -- ${element.address}');
        });
        print('Device: ${devices[0].name}');
      });
      */
    } catch (exception) {
      print('Cannot Scan, ${exception.toString()}');
    }
  }

  Future<bool?> checkIsOn() {
    return FlutterBluetoothSerial.instance.isEnabled;
  }

  Future<int> connectDevice() async {
    try {
      if (device?.isConnected == false) {
        connection = await BluetoothConnection.toAddress(device?.address);
        showToast('Connected to the device', TOAST_STATUS.TOAST_SUCCESS);
        return 0; // SUCCESS
      }
      return 0; // SUCCESS
    } catch (exception) {
      devices.remove(device);
      showToast('Cannot Connect', TOAST_STATUS.TOAST_FAILED);
      print(exception);
      return 1; // FAILED
    }
  }

  Future<void> request_bluetooth() async {
    await FlutterBluetoothSerial.instance.requestEnable();
  }

  readData() {
    connection?.input?.listen((Uint8List data) {
      print('Data incoming: ${ascii.decode(data)}');

      information = '$information${ascii.decode(data).toString()}';
      print(information);
    });
  }
}
