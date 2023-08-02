import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weatherapp/my_text.dart';
import 'package:weatherapp/size_config.dart';

//수치에 따른 표정 이미지 리스트
List<String> expression = [
  'assets/images/smile.png',
  'assets/images/expressionless.png',
  'assets/images/bad.png'
];
//수치에 따른 표현 리스트
List<String> words = ['좋음', '보통', '나쁨', '매우 나쁨'];
//수치에 따른 위젯의 배경 색 리스트
List<Color> typicalColors = [
  Color(0xff251C5F),
  Color(0xffFFDD72),
  Color(0xffEF3F69)
];

Widget uviAndDustWidget() {
  return Padding(
    padding: EdgeInsets.only(
        right: SizeConfig.screenWidth * 0.05,
        left: SizeConfig.screenWidth * 0.05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        uviHelper(),
        SizedBox(width: SizeConfig.screenWidth * 0.02),
        dustHelper(),
      ],
    ),
  );
}

Widget uviHelper() {
  var uvi = 0;
  if (Get.arguments['weatherData']['current']['uvi'] != 0) {
    uvi = Get.arguments['weatherData']['current']['uvi'];
  }
  Color resultColor = typicalColors[0];
  String resultExpression = '';
  String resultWords = '';
  if (uvi <= 2) {
    resultColor = typicalColors[0];
    resultExpression = expression[0];
    resultWords = words[0];
  }
  if (uvi >= 3 && uvi <= 5) {
    resultColor = typicalColors[1];
    resultExpression = expression[1];
    resultWords = words[1];
  }
  if (uvi >= 6 && uvi <= 7) {
    resultColor = typicalColors[2];
    resultExpression = expression[2];
    resultWords = words[2];
  }
  if (uvi > 7) {
    resultColor = typicalColors[2];
    resultExpression = expression[2];
    resultWords = words[3];
  }
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: resultColor,
      borderRadius: BorderRadius.circular(50),
    ),
    width: SizeConfig.screenWidth * 0.44,
    height: 180,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/sun.png', width: 20),
            SizedBox(width: 10),
            MyText.bold('자외선', MyText.BODY, Colors.white)
          ],
        ),
        SizedBox(height: 10),
        Image.asset(resultExpression),
        SizedBox(height: 10),
        MyText.normal(resultWords, MyText.BODY, Colors.white),
        SizedBox(height: 10),
      ],
    ),
  );
}

Widget dustHelper() {
  int aqi = Get.arguments['airData']['list'][0]['main']['aqi'];
  Color resultColor = typicalColors[0];
  String resultExpression = '';
  String resultWords = '';
  if (aqi <= 1) {
    resultColor = typicalColors[0];
    resultExpression = expression[0];
    resultWords = words[0];
  }
  if (aqi == 2 || aqi == 3) {
    resultColor = typicalColors[1];
    resultExpression = expression[1];
    resultWords = words[1];
  }
  if (aqi == 4) {
    resultColor = typicalColors[2];
    resultExpression = expression[2];
    resultWords = words[2];
  }
  if (aqi == 5) {
    resultColor = typicalColors[2];
    resultExpression = expression[2];
    resultWords = words[3];
  }
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: resultColor,
      borderRadius: BorderRadius.circular(50),
    ),
    width: SizeConfig.screenWidth * 0.44,
    height: 180,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/dust.png', width: 20),
            SizedBox(width: 10),
            MyText.bold('미세먼지', MyText.BODY, Colors.white)
          ],
        ),
        SizedBox(height: 10),
        Image.asset(resultExpression),
        SizedBox(height: 10),
        MyText.normal(resultWords, MyText.BODY, Colors.white),
        SizedBox(height: 10),
      ],
    ),
  );
}
