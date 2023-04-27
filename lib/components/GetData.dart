import 'package:application_gp/Models/testData.dart';

class Getting_data {
  static testData test = testData(
      modelName: 'AWSQM',
      gps_lat: 0,
      gps_long: 0,
      pH: 0,
      Temperature: 0,
      TDS: 0,
      turbidity: 0,
      status: 0,
      errorCode: 0);
  static void getData(List<String> globalData) {
    try {
      String data = globalData.join();

      List<String> localData = data.split(RegExp('[@;]'));
      print(localData);
      // Cleaning list of dirty elements
      localData.removeWhere((element) {
        final regExp = RegExp(",");

        if (regExp.allMatches(element).length != 8) {
          return true;
        }
        return false;
      });

      List<String> fields = localData.first.split(',');
      print('fields');
      print(fields);
      // || Parsing

      String modelName = fields[0].substring(1);

      double gpsLat = double.parse(fields[1]);

      double gpsLong = double.parse(fields[2]);

      double pH = double.parse(fields[3]);

      double temperature = double.parse(fields[4]);

      double tds = double.parse(fields[5]);

      double turbidity = double.parse(fields[6]);

      if (int.parse(fields[7]) == 2) {
        pH = double.parse(fields[3]);
        temperature = double.parse(fields[4]);
        tds = double.parse(fields[5]);
        turbidity = double.parse(fields[6]);
      }

      int status1 = int.parse(fields[7]);

      int errorCode = int.parse(fields[8]);

      // || Assigning into model

      test.modelName = modelName;
      test.gps_lat = gpsLat;
      test.gps_long = gpsLong;
      if (status1 == 2) {
        test.pH = pH;
        test.Temperature = temperature;
        test.TDS = tds;
        test.turbidity = turbidity;
      }
      test.status = status1;
      test.errorCode = errorCode;

      print('success');
    } catch (ex) {
      print(ex);
    }
  }
}
