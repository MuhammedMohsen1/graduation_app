import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/modules/Customer/cubit/customer_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class Customer_Dashboard extends StatelessWidget {
  const Customer_Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CustomerCubitCubit(),
      child: BlocConsumer<CustomerCubitCubit, CustomerCubitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CustomerCubitCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      background.withOpacity(0.5),
                      background.withOpacity(0.4),
                      background.withOpacity(0.3),
                      background.withOpacity(0.2),
                      Colors.white,
                      Colors.white,
                    ],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 14,
                              right: 14,
                              top: 14,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: textColor,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    width: size.width / 7,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/profile_photo.png'),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Mohammed Mohsen',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: .8,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: background_dark,
                                        border: Border.all(
                                          width: 0.5,
                                          color: textColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Sign out',
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: size.height * 0.015,
                                            letterSpacing: 1.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  "assets/images/save_water.png",
                                  width: size.width * 0.5,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Keep it pure,',
                                            style: TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.w300,
                                              fontSize: size.height * 0.032,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              'water is yours.',
                                              style: TextStyle(
                                                color: textColor,
                                                fontWeight: FontWeight.w300,
                                                fontSize: size.height * 0.032,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48.0, vertical: 16),
                        child: Container(
                          height: size.height / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 7.5,
                                  color: primaryColor,
                                  blurStyle: BlurStyle.inner)
                            ],
                          ),
                          child: Row(children: [
                            BottomIcon(
                              cubit: cubit,
                              index: 0,
                              icon: Icons.home_rounded,
                            ),
                            BottomIcon(
                              cubit: cubit,
                              index: 1,
                              icon: LineIcons.plus,
                            ),
                            BottomIcon(
                              cubit: cubit,
                              index: 2,
                              icon: LineIcons.creditCard,
                            ),
                            BottomIcon(
                              cubit: cubit,
                              index: 3,
                              icon: LineIcons.ship,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  const BottomIcon({
    super.key,
    required this.cubit,
    required this.index,
    required this.icon,
  });
  final int index;
  final CustomerCubitCubit cubit;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          cubit.changeTheScreen(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Icon(
            icon,
            shadows: [
              Shadow(
                  color: cubit.screenIndex == index
                      ? Colors.black
                      : Colors.transparent,
                  blurRadius: 20.0)
            ],
            color: cubit.screenIndex == index ? background : textColor,
          ),
        ),
      ),
    );
  }
}
