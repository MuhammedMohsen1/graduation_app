import 'dart:convert';
import 'dart:typed_data';

import 'package:application_gp/components/bluetooth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../Models/testData.dart';
import '../../../components/GetData.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitial());
  double percentage = 0;

  static get(context) => BlocProvider.of<GetDataCubit>(context);
  static List<String> information = [''];
  void readData(Bluetooth bluetooth) {
    information.add('');
    bluetooth.connection?.input?.listen((Uint8List data) {
      String asci = ascii.decode(data).toString().replaceAll('null', '');

      information.add(asci);

      if (asci.contains(';')) {
        getData(information);
        information.clear();
      }
    });
  }

  void getData(List<String> globalData) {
    try {
      String data = globalData.join();

      List<String> localData = data.split(RegExp('[@;]'));

      // Cleaning list of dirty elements
      localData.removeWhere((element) {
        final regExp = RegExp(",");

        if (regExp.allMatches(element).length != 8) {
          return true;
        }
        return false;
      });

      List<String> fields = localData.first.split(',');

      // || Parsing

      String modelName = fields[0].substring(1);

      double gpsLat = double.parse(fields[1]);

      double gpsLong = double.parse(fields[2]);

      double pH = double.parse(fields[3]);

      double temperature = double.parse(fields[4]);

      double tds = double.parse(fields[5]);

      double turbidity = double.parse(fields[6]);

      int status1 = int.parse(fields[7]);

      int errorCode = int.parse(fields[8]);
      Getting_data.test = testData(
          modelName: modelName,
          gps_lat: gpsLat,
          gps_long: gpsLong,
          pH: pH,
          Temperature: temperature,
          TDS: tds,
          turbidity: turbidity,
          status: status1,
          errorCode: errorCode);
      //Status
      if (status1 == 0 && errorCode == 0) {
        emit(GetDataNavigateToGoal());
        emit(GetDataUpdateLocation());

        percentage = 20;
      } else if (status1 == 1 && errorCode == 0) {
        emit(GetDataCollectingData());
        emit(GetDataUpdateLocation());

        percentage = 62;
      } else if (status1 == 2 && errorCode == 0) {
        emit(GetDataNavigateBack());
        emit(GetDataUpdateLocation());

        percentage = 88;
      } else if (status1 == 3 && errorCode == 0) {
        emit(GetDataDone());
        emit(GetDataUpdateLocation());

        percentage = 95.5;
      }

      if (errorCode != 0) {
        emit(GetDataError());
      }

      // || Assigning into model

      print('success');
    } catch (ex) {
      print(ex);
    }
  }
}
