import 'package:flutter/cupertino.dart';

/// 전체 스크린 비율 기준으로 크기 설정 시 사용하는 클래스.
/// 마지막 수정 : 2023. 8. 2.
class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static Orientation? orientation;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
  }
}
