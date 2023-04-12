import 'package:application_gp/modules/Customer/Screens/HomeScreen.dart';
import 'package:application_gp/modules/Customer/Screens/ShipScreen.dart';
import 'package:application_gp/modules/Customer/Screens/SubscriptionScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../components/position.dart';
import '../../../components/updatingData.dart';
import '../Screens/AddScreen.dart';

part 'customer_cubit_state.dart';

class CustomerCubitCubit extends Cubit<CustomerCubitState> {
  Position position = GetPosition(true).get();
  CustomerCubitCubit() : super(CustomerCubitInitial());
  static CustomerCubitCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<Map<String, dynamic>> data = [];
  Map<String, dynamic> nearest_test = {};

  List<Widget> screens = [
    HomeScreen(),
    AddScreen(),
    SubscriptionScreen(),
    ShipScreen(),
  ];

  int screenIndex = 0;
  void changeTheScreen(int screenIndex) {
    if (screenIndex == 1) {
      position = GetPosition(false).get();
    }
    this.screenIndex = screenIndex;

    emit(CustomerCubitChangeScreenState());
  }

  Future<void> fetchData() async {
    fetchTestsFromFirestore().then((value) {
      data = value;

      nearest_test =
          findNearestLocation(position.latitude, position.longitude, data);

      print('done fetching data');
    });
  }
}
