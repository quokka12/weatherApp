import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MyLocation {
  late double latitude2;
  late double longitude2;

  Future<void> getMyCurrentLocation() async {
    var requestStatus = await Permission.location.request();
    var status = await Permission.location.status;
    if (requestStatus.isGranted && status.isLimited) {
      // isLimited - 제한적 동의 (ios 14 < )
      // 요청 동의됨
      print("isGranted");
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
        // 요청 동의 + gps 켜짐
        var position = await Geolocator.getCurrentPosition();
        print("serviceStatusIsEnabled position = ${position.toString()}");
      } else {
        // 요청 동의 + gps 꺼짐
        print("serviceStatusIsDisabled");
      }
    } else if (requestStatus.isPermanentlyDenied ||
        status.isPermanentlyDenied) {
      // 권한 요청 거부, 해당 권한에 대한 요청에 대해 다시 묻지 않음 선택하여 설정화면에서 변경해야함. android
      print("isPermanentlyDenied");
    } else if (status.isRestricted) {
      // 권한 요청 거부, 해당 권한에 대한 요청을 표시하지 않도록 선택하여 설정화면에서 변경해야함. ios
      print("isRestricted");
      openAppSettings();
    } else if (status.isDenied) {
      // 권한 요청 거절
      print("isDenied");
    }
    print("requestStatus ${requestStatus.name}");
    print("status ${status.name}");

    if (status.isGranted) {
      // 1-2. 권한이 있는 경우 위치정보를 받아와서 변수에 저장합니다.
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print("$longitude2, $latitude2");
    }
  } // ...getMyCurrentLocation()
}
