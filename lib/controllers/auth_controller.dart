import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  setIsloadingValue(bool value) {
    isLoading.value = value;
  }
}
