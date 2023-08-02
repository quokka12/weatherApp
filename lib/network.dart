import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http_pk;
import 'dart:convert';

import 'package:weatherapp/my_text.dart'; // jsonDcode 사용 가능

class Network {
  late final String url; // 날씨정보
  late final String url2; // 미세먼지(기상정보)

  // 생성자 : 앞 loading 코드에서 보낸 주소를 받습니다.
  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async {
    http_pk.Response response = await http_pk.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);

      return parsingData;
    } else {
      // 예외상황 처리
      Get.dialog(AlertDialog(
        title: MyText.bold('날씨 서버 접속 오류', MyText.TITLE3, Colors.black87),
        content: MyText.normal(
            '서버에 접속하지 못했습니다.\n어플을 다시 실행해주세요.', MyText.BODY, Colors.black87),
        actions: [
          TextButton(
              onPressed: () {
                SystemNavigator.pop();
                exit(0);
              },
              child: MyText.normal('확인', MyText.BODY, Colors.black87))
        ],
      ));
    }
  } // ...getJsonData()

  Future<dynamic> getAirData() async {
    http_pk.Response response = await http_pk.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);

      return parsingData;
    } else {
      // 예외상황 처리
      Get.dialog(AlertDialog(
        title: MyText.bold('날씨 서버 접속 오류', MyText.TITLE3, Colors.black87),
        content: MyText.normal(
            '서버에 접속하지 못했습니다.\n어플을 다시 실행해주세요.', MyText.BODY, Colors.black87),
        actions: [
          TextButton(
              onPressed: () {
                SystemNavigator.pop();
                exit(0);
              },
              child: MyText.normal('확인', MyText.BODY, Colors.black87))
        ],
      ));
    }
  } // ...getAirData()
}
