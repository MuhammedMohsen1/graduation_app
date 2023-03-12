import 'package:application_gp/components/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';

import '../../Constants/constant.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.isBoat});
  final bool isBoat;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          isBoat ? 'BOATS' : 'TESTS',
          style: TextStyle(
            fontSize: size.height * 0.025,
            color: textColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              navigateBack(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: textColor,
            )),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                border: Border.all(
                  width: 0.2,
                  color: textColor,
                ),
                color: background.withOpacity(0.35),
              ),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        height: size.height * 0.16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            IgnorePointer(
                              ignoring: true,
                              child: FlutterMap(
                                options: MapOptions(
                                    center: LatLng(29.341089, 31.212216),
                                    zoom: 13.0),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        "https://api.tomtom.com/map/1/tile/basic/main/"
                                        "{z}/{x}/{y}.png?key={apiKey}",
                                    additionalOptions: {"apiKey": apiKey},
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on,
                                    size: 20.0, color: textColor),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "Test's here",
                                  style: TextStyle(
                                      fontSize: size.height * 0.012,
                                      letterSpacing: 1,
                                      color: textColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2.0),
                        child: Container(
                          height: 0.2,
                          color: textColor,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isBoat) ...{
                                Text(
                                  'MOHSEN-1',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Version v1.0.0',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'A1976C2023',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Price: 8999.99 LE',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                              } else ...[
                                Text(
                                  'Mohamed Mohsen',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  '01067042473',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                              ]
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '2 days ago',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: size.height * 0.011,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.0),
                              ),
                              const SizedBox(height: 2.0),
                              ElevatedButton(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: background_dark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.014,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
