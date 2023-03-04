import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'customer_cubit_state.dart';

class CustomerCubitCubit extends Cubit<CustomerCubitState> {
  CustomerCubitCubit() : super(CustomerCubitInitial());
  static CustomerCubitCubit get(BuildContext context) =>
      BlocProvider.of(context);
  List<Widget> screens = [];
  int screenIndex = 0;
  void changeTheScreen(int screenIndex) {
    this.screenIndex = screenIndex;
    print("I am in Change The Screen function");
    emit(CustomerCubitChangeScreenState());
  }
}
