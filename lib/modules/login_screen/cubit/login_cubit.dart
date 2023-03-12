import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../components/functions.dart';
import '../../../components/navigator.dart';
import '../../../components/sharedPreference.dart';
import '../../../layout/dashboard_layout.dart';
import '../../Customer/Customer_Dashboard.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void login_button(BuildContext context) async {
    emit(LoginLoadingState());
    print('login Loading');
    await Future.delayed(Duration(seconds: 3));
    if (validate(email.text, password.text)) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        if (value.toString().isNotEmpty) {
          FirebaseFirestore.instance
              .collection('users_role')
              .doc(email.text)
              .get()
              .then((value) {
            var data = value.data();

            if (data?.values.first == 'Employee') {
              store_data('isEmployee', true, types.BOOL);
              navigateToAndReplace(context, const DashboardLayout());
            } else {
              store_data('isEmployee', false, types.BOOL);
              navigateToAndReplace(context, const Customer_Dashboard());
            }
            store_data('isLogin', true, types.BOOL);
          }).onError((error, stackTrace) {
            emit(LoginFetchedState());
          });
          emit(LoginFetchedState());
        }
        emit(LoginFetchedState());
      }).onError((error, stackTrace) {
        showToast('Failed', TOAST_STATUS.TOAST_FAILED);
        emit(LoginFetchedState());
      });

      email.clear();
      password.clear();
    } else {
      emit(LoginFetchedState());
    }
  }
}
