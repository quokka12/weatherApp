import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weatherapp/screens/home/home_screen.dart';

import '../my_location.dart';
import '../network.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  static const WEATHER_API_KEY = '51835b8f3fd92a8f388437114c474620'; // 위와 동일.

  late double latitude3;
  late double longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffFFDD72), //Colors.amber
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }

  void getLocation() async {
    // 앞 포스팅에서 만들었던 위치정보 클래스 사용
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();

    // 받아온 위치(위, 경도 값)을 변수에 저장
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    // 네트워크 인스턴스 영역
    Network network = Network(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$latitude3&lon=$longitude3&appid=$WEATHER_API_KEY&units=metric&exclude=minutely,alerts',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$WEATHER_API_KEY');
    // 새로 추가되는 부분
    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();
    Get.to(HomeScreen(),
        arguments: {'weatherData': weatherData, 'airData': airData},
        transition: Transition.fade);
  } // ...getLocation()
}
