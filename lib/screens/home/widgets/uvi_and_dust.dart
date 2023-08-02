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

/// 자외선과 미세먼지 정도를 알려주는 위젯
/// 마지막 수정 : 2023. 8. 2.
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

/// 자외선 위젯
/// 마지막 수정 : 2023. 8. 2.
Widget uviHelper() {
  var uvi = 0;

  // uvi가 0이 아닐 때는 double타입이 때문에, 따로 설정해줘야한다.(0일 때는 정수)
  if (Get.arguments['weatherData']['current']['uvi'] != 0) {
    uvi = Get.arguments['weatherData']['current']['uvi'];
  }

  // 결과에 따른 배경색상, 캐릭터 표정, 표현하는 말을 저장하는 변수들
  Color resultColor = typicalColors[0]; // 배경색상 저장
  String resultExpression = ''; // 캐릭터 표정
  String resultWords = ''; // 표현하는 말

  // uvi정도에 따른 결과값을 표현하기 위해 if문으로 나눔.
  // 2 이하 : 좋음
  if (uvi <= 2) {
    resultColor = typicalColors[0];
    resultExpression = expression[0];
    resultWords = words[0];
  }
  // 3 ~ 5 : 보통
  if (uvi >= 3 && uvi <= 5) {
    resultColor = typicalColors[1];
    resultExpression = expression[1];
    resultWords = words[1];
  }
  // 6 ~ 7 : 나쁨
  if (uvi >= 6 && uvi <= 7) {
    resultColor = typicalColors[2];
    resultExpression = expression[2];
    resultWords = words[2];
  }
  // 8 이상 : 매우 나쁨
  if (uvi >= 8) {
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

/// 미세먼지 위젯
/// 마지막 수정 : 2023. 8. 2.
Widget dustHelper() {
  // aqi : 대기 상태를 뜻함
  int aqi = Get.arguments['airData']['list'][0]['main']['aqi'];

  // 결과에 따른 배경색상, 캐릭터 표정, 표현하는 말을 저장하는 변수들
  Color resultColor = typicalColors[0]; // 배경색상 저장
  String resultExpression = ''; // 캐릭터 표정
  String resultWords = ''; // 표현하는 말

  // aqi -> 1 : 좋음, 2 ~ 3 : 보통, 4 : 나쁨, 5 : 매우 나쁨.
  switch (aqi) {
    case 1:
      resultColor = typicalColors[0];
      resultExpression = expression[0];
      resultWords = words[0];
      break;
    case 2:
    case 3:
      resultColor = typicalColors[1];
      resultExpression = expression[1];
      resultWords = words[1];
      break;
    case 4:
      resultColor = typicalColors[2];
      resultExpression = expression[2];
      resultWords = words[2];
      break;
    case 5:
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
