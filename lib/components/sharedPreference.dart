import 'package:shared_preferences/shared_preferences.dart';

enum types { BOOL, INT, DOUBLE, STRING }

Future<SharedPreferences> get_data(
  String title,
) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref;
}

void store_data(String title, dynamic data, types type) async {
  await SharedPreferences.getInstance().then((value) {
    if (type == types.BOOL) {
      value.setBool(title, data as bool).then((value) {
        print('Store Successfully');
        print(value);
      });
    } else if (type == types.INT) {
      value.setInt(title, data as int);
    } else if (type == types.DOUBLE) {
      value.setDouble(title, data as double);
    } else if (type == types.STRING) {
      value.setString(title, data as String);
    }
  });
}
