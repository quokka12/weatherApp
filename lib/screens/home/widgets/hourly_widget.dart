import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/my_text.dart';

import '../../../function.dart';
import '../../../size_config.dart';

/// 시간 별 정보를 나타내는 위젯
/// @param : 탭바 컨트롤러, 현재 시간, 일출시간, 일몰시간
/// 코드 수정 : 2023. 8. 2.
Widget hourlyWidget(tabcontroller, timeNow, sunrise, sunset) {
  return Column(
    children: [
      Container(
        height: 40,
        width: 260,
        decoration: BoxDecoration(
          color: Color(0xffededed),
          borderRadius: BorderRadius.circular(25),
        ),
        child: TabBar(
          indicator: BoxDecoration(
            color: timeNow > sunset || timeNow < sunrise
                ? Color(0xff251C5F)
                : Color(0xffEF3F69),
            borderRadius: BorderRadius.circular(25),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: <Tab>[
            Tab(text: '날씨'),
            Tab(text: '강수'),
            Tab(text: '바람'),
            Tab(text: '습도'),
          ],
          controller: tabcontroller,
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        width: SizeConfig.screenWidth * 0.93,
        height: 180,
        child: TabBarView(
          children: <Widget>[
            hourlyTempWidget(Get.arguments['weatherData'], sunrise, sunset),
            hourlyRainOrSnowWidget(Get.arguments['weatherData']),
            hourlyWindWidget(Get.arguments['weatherData']),
            hourlyHumidityWidget(Get.arguments['weatherData']),
          ],
          controller: tabcontroller,
        ),
      ),
    ],
  );
}

/// 시간 별 온도를 나타내는 위젯
/// @param : 날씨 데이터, 일출 시간(HH), 일몰 시간(HH)
/// 코드 수정 : 2023. 8. 2.
Widget hourlyTempWidget(var weatherData, int sunrise, int sunset) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < 24; i++) ...[
          hourTempItemHelper(weatherData['hourly'][i]['dt'],
              weatherData['hourly'][i]['temp'].toString(), sunrise, sunset),
          SizedBox(width: 5),
        ],
      ],
    ),
  );
}

/// 각 시간 온도를 나타내는 아이템
/// @param : 시간(HH), 온도(00.00), 일출 시간(HH), 일몰 시간(HH)
/// 코드 수정 : 2023. 8. 2.
Widget hourTempItemHelper(int time, String temp, int sunrise, int sunset) {
  String str_time = utcToHour(time);
  return Padding(
    padding: EdgeInsets.all(3),
    child: Container(
      padding: EdgeInsets.all(10),
      width: 61,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
            ),
          ]),
      child: Column(
        children: [
          MyText.bold('${str_time}시', MyText.BODY, Colors.black87),
          SizedBox(height: 10),
          Image.asset(
              int.parse(str_time) > sunset || int.parse(str_time) < sunrise
                  ? 'assets/images/moon.png'
                  : 'assets/images/sun_color.png'),
          SizedBox(height: 10),
          MyText.normal('${cutStringTemp(temp)}°', MyText.BODY, Colors.black87),
        ],
      ),
    ),
  );
}

/// 시간 별 습도를 나타내는 위젯
/// @param : 날씨 데이터
/// 코드 수정 : 2023. 8. 2.
Widget hourlyHumidityWidget(var weatherData) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < 24; i++) ...[
          hourHumidityItemHelper(weatherData['hourly'][i]['dt'],
              weatherData['hourly'][i]['humidity'].toString()),
          SizedBox(width: 5),
        ],
      ],
    ),
  );
}

/// 각 시간 온도를 나타내는 아이템
/// @param : 시간(HH), 습도(00)
/// 코드 수정 : 2023. 8. 2.
Widget hourHumidityItemHelper(int time, var humidity) {
  String str_time = utcToHour(time);
  return Padding(
    padding: EdgeInsets.all(3),
    child: Container(
      padding: EdgeInsets.all(10),
      width: 61,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
            ),
          ]),
      child: Column(
        children: [
          MyText.bold('${str_time}시', MyText.BODY, Colors.black87),
          SizedBox(height: 10),
          Image.asset('assets/images/humidity0.png'),
          SizedBox(height: 10),
          MyText.normal('${humidity}%', MyText.BODY, Colors.black87),
        ],
      ),
    ),
  );
}

/// 시간 별 강수확률, 강수량(눈,비)을 나타내는 위젯
/// @param : 날씨 데이터
/// 코드 수정 : 2023. 8. 2.
Widget hourlyRainOrSnowWidget(var weatherData) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < 24; i++) ...[
          hourRainOrSnowItemHelper(
              weatherData['hourly'][i]['dt'], weatherData['hourly'][i]),
          SizedBox(width: 5),
        ],
      ],
    ),
  );
}

/// 각 시간 강수확률 및 강수량(눈,비)을 나타내는 아이템
/// @param : 시간(HH), 그 시간의 날씨 데이터(json)
/// 코드 수정 : 2023. 8. 2.
Widget hourRainOrSnowItemHelper(int time, var weatherData) {
  String str_time = utcToHour(time);
  var amountOfRainfall;
  if (weatherData['pop'] == 0) {
    amountOfRainfall = 0;
  } else {
    amountOfRainfall = weatherData['pop'] * 100;
  }
  double precipitation = 0;
  if (weatherData['rain'] != null) {
    precipitation = weatherData['rain']['1h'];
  }
  if (weatherData['snow'] != null) {
    precipitation = weatherData['snow']['1h'];
  }
  return Padding(
    padding: EdgeInsets.all(3),
    child: Container(
      padding: EdgeInsets.all(10),
      width: 80,
      height: 145,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
            Colors.blue,
          ],
          // 강수 확률에 맞춰 파란색 색상을 주기 위해 (1 - 강수확률) 높을 수록 하얘짐.
          stops: [0.0, 1.0 - weatherData['pop'], 1.0 - weatherData['pop']],
        ),
      ),
      child: Column(
        children: [
          MyText.bold('${str_time}시', MyText.BODY, Colors.black87),
          SizedBox(height: 10),
          MyText.normal('${precipitation}', MyText.BODY, Colors.black87),
          MyText.normal('mm/h', MyText.BODY, Colors.black87),
          SizedBox(height: 10),
          MyText.normal('${int.parse(amountOfRainfall.toString())}%',
              MyText.BODY, Colors.black87),
        ],
      ),
    ),
  );
}

/// 시간 별 바람(세기, 방향)을 나타내는 위젯
/// @param : 날씨 데이터
/// 코드 수정 : 2023. 8. 2.
Widget hourlyWindWidget(var weatherData) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < 24; i++) ...[
          hourWindItemHelper(
              weatherData['hourly'][i]['dt'], weatherData['hourly'][i]),
          SizedBox(width: 5),
        ],
      ],
    ),
  );
}

/// 각 시간 바람(세기, 방향)을 나타내는 아이템
/// @param : 시간(HH), 그 시간의 날씨 데이터(json)
/// 코드 수정 : 2023. 8. 2.
Widget hourWindItemHelper(int time, var weatherData) {
  String str_time = utcToHour(time);
  String directions = '북풍';
  if (weatherData['wind_deg'] > 1 && weatherData['wind_deg'] <= 45) {
    directions = '북동풍';
  }
  if (weatherData['wind_deg'] > 46 && weatherData['wind_deg'] <= 90) {
    directions = '동풍';
  }
  if (weatherData['wind_deg'] > 91 && weatherData['wind_deg'] <= 135) {
    directions = '남동풍';
  }
  if (weatherData['wind_deg'] > 136 && weatherData['wind_deg'] <= 180) {
    directions = '남풍';
  }
  if (weatherData['wind_deg'] > 181 && weatherData['wind_deg'] <= 225) {
    directions = '남서풍';
  }
  if (weatherData['wind_deg'] > 226 && weatherData['wind_deg'] <= 270) {
    directions = '서풍';
  }
  if (weatherData['wind_deg'] > 271 && weatherData['wind_deg'] <= 315) {
    directions = '북서풍';
  }
  return Padding(
    padding: EdgeInsets.all(3),
    child: Container(
      padding: EdgeInsets.all(10),
      width: 80,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
            ),
          ]),
      child: Column(
        children: [
          MyText.bold('${str_time}시', MyText.BODY, Colors.black87),
          SizedBox(height: 10),
          MyText.normal('${directions}', MyText.BODY, Colors.black87),
          SizedBox(height: 10),
          MyText.normal(
              '${cutStringTemp(weatherData['wind_speed'].toString())}2m/s',
              MyText.BODY,
              Colors.black87),
        ],
      ),
    ),
  );
}
