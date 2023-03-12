class testData {
  testData({
    required this.modelName,
    required this.gps_lat,
    required this.gps_long,
    required this.pH,
    required this.Temperature,
    required this.TDS,
    required this.turbidity,
    required this.status,
    required this.errorCode,
  });
  String modelName;
  double gps_lat;
  double gps_long;
  double pH;
  double Temperature;
  double TDS;
  double turbidity;
  int status;
  int errorCode;
}
