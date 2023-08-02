import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/screens/home/widgets/hourly_widget.dart';
import 'package:weatherapp/screens/home/widgets/uvi_and_dust.dart';

import '../../function.dart';
import '../../my_text.dart';
import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? temp; // 현재 온도
  String? feels_like; // 체감 온도
  int sunrise = 0;
  int sunset = 0;
  int timeNow = 0;
  TabController? tabcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = cutStringTemp(
        Get.arguments['weatherData']['current']['temp'].toString());
    feels_like = cutStringTemp(
        Get.arguments['weatherData']['current']['feels_like'].toString());
    tabcontroller = TabController(length: 4, vsync: this);
    sunrise = int.parse(
        utcToHour(Get.arguments['weatherData']['current']['sunrise']));
    sunset =
        int.parse(utcToHour(Get.arguments['weatherData']['current']['sunset']));
    DateTime dt = DateTime.now();
    timeNow = dt.hour;
  }

  @override
  void dispose() {
    tabcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: timeNow > sunset || timeNow < sunrise
          ? Color(0xff251C5F)
          : Color(0xffEF3F69),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.checkroom_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    Image.asset('assets/images/sun.png'),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              MyText.bold('청명해요', MyText.TITLE1, Colors.white),
              MyText.bold('${temp}°', 64, Colors.white),
              MyText.normal('일출시간 : ${sunrise}시 / 일몰시간 : ${sunset}시',
                  MyText.BODY, Colors.white),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 2000,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/background.png'), // 배경 이미지
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 310),
                    hourlyWidget(tabcontroller, timeNow, sunrise, sunset),
                    uviAndDustWidget(),
                    Container(
                      padding: EdgeInsets.all(25),
                      alignment: Alignment.centerLeft,
                      child:
                          MyText.bold('이번 주 날씨', MyText.TITLE3, Colors.black87),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
