import 'package:application_gp/modules/Customer/Screens/HomeScreen.dart';
import 'package:application_gp/modules/Customer/Screens/ShipScreen.dart';
import 'package:application_gp/modules/Customer/Screens/SubscriptionScreen%20copy.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../components/position.dart';
import '../Screens/AddScreen.dart';

part 'customer_cubit_state.dart';

class CustomerCubitCubit extends Cubit<CustomerCubitState> {
  Position position = GetPosition().get();
  CustomerCubitCubit() : super(CustomerCubitInitial());
  static CustomerCubitCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    AddScreen(),
    SubscriptionScreen(),
    ShipScreen(),
  ];

  int screenIndex = 1;
  void changeTheScreen(int screenIndex) {
    this.screenIndex = screenIndex;
    print("I am in Change The Screen function");
    emit(CustomerCubitChangeScreenState());
  }
}
