import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:flutter/material.dart';

import '../../components/record_item.dart';

class ViewMore extends StatelessWidget {
  const ViewMore({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background_dark,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: textColor,
            ),
            onPressed: () {
              navigateBack(context);
            }),
        title: const Text(
          'Records',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.7,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) => RecordItem(size: size, isClean: false),
      ),
    );
  }
}
