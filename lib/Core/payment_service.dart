import 'package:application_gp/Core/Api_keys.dart';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'dio.dart';

class StripeService {
  final DioHelper apiService = DioHelper();
  Future<Map<String, dynamic>> createPaymentIntent() async {
    var response = await apiService.post(
      'https://api.stripe.com/v1/payment_intents',
      {
        'amount': '1000',
        'currency': 'usd',
      },
      ApiKeys.secretKey,
      null,
    );

    return {
      'client_secret': response.data['client_secret'],
      'customer': response.data['customer'],
    };
  }

  Future initPaymentSheet(
      {required Map<String, dynamic> PaymentInputData}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: PaymentInputData['client_secret'],
        customerEphemeralKeySecret: PaymentInputData['ephemeralKey'],
        customerId: PaymentInputData['customer'],
        merchantDisplayName: 'tharwat',
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({required Map<String, dynamic> PaymentInputData}) async {
    var paymentIntentModel = await createPaymentIntent();
    var ephemeralKeyModel =
        await createEphemeralKey(customerId: PaymentInputData['customer']);
    var paymentInputModel = {
      'client_secret': paymentIntentModel['client_secret'],
      'customer': paymentIntentModel['customer'],
      'ephemeralKey': ephemeralKeyModel,
    };

    await initPaymentSheet(PaymentInputData: paymentInputModel);
    await displayPaymentSheet();
  }

  Future<String> createEphemeralKey({required String customerId}) async {
    var response = await apiService.post(
      'https://api.stripe.com/v1/ephemeral_keys',
      {'customer': customerId},
      ApiKeys.secretKey,
      {
        'Authorization': "Bearer ${ApiKeys.secretKey}",
        'Stripe-Version': '2023-08-16',
      },
    );

    var ephermeralKey = response.data['ephemeral_key'];

    return ephermeralKey;
  }
}
