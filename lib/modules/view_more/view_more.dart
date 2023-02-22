import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:flutter/material.dart';

import '../../components/record_item.dart';
import '../../components/view_more_button.dart';

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
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) => RecordItem(size: size, isClean: false),
      ),
    );
  }
}
