import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // lazyPut ensures the controller is only initialized when the page is actually opened
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
