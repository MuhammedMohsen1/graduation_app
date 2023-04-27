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
    try {
      information.add('');
      bluetooth.connection?.input?.listen((Uint8List data) {
        String asci = ascii.decode(data).toString().replaceAll('null', '');

        information.add(asci);

        if (asci.contains(';')) {
          // print('information');
          // for (var element in information) {
          //   print(element);
          // }
          // print('End of information');
          getData(information);
          information.clear();
        }
      });
    } catch (e) {
      print('reading');
      print(e);
    }
  }

  void getData(List<String> globalData) {
    String data = globalData.join();

    List<String> localData = data.split(RegExp('[@;]'));
    print('localData');
    for (var element in localData) {
      print(element);
    }
    // Cleaning list of dirty elements
    localData.removeWhere((element) {
      final regExp = RegExp(",");

      if (regExp.allMatches(element).length != 8) {
        print('Deleted');
        return true;
      }
      return false;
    });

    List<String> fields = localData.first.split(',');

    print('fields');
    print(localData.first);

    // || Parsing

    String modelName = fields[0];

    double gpsLat = double.parse(filter(fields[1]));

    double gpsLong = double.parse(filter(fields[2]));

    double pH = double.parse(filter(fields[3]));

    double temperature = double.parse(filter(fields[4]));

    double tds = double.parse(filter(fields[5]));

    double turbidity = double.parse(filter(fields[6]));

    int status1 = int.parse(filter(fields[7]));

    int errorCode = int.parse(filter(fields[8]));

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
  }

  String filter(String str) {
    List<String> allowedChars = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '.',
      ',',
      '-',
      '_',
      '+',
      '/',
      '=',
      ':',
      ';',
      '(',
      ')',
      '[',
      ']',
      '{',
      '}',
      '@',
      '#',
      '%',
      '&',
      '*',
      '!',
      '?',
      '|',
      '~',
      '`',
      '^',
      ' ',
      '\n',
      '\t',
      '\r'
    ];
    return str.split('').where((char) => allowedChars.contains(char)).join();
  }
}
