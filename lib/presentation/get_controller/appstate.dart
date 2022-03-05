import 'package:get/get.dart';

class AppState extends GetxController {
  RxString usertyperx = "".obs;
  RxString restorx = "".obs;

  changedata(String usertype, String resto) {
    usertyperx.value = usertype;
    restorx.value = resto;
  }
}
