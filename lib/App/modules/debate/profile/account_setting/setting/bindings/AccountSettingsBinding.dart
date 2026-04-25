import 'package:get/get.dart';
import '../controller/AccountSettingsController.dart';

class AccountSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSettingsController>(() => AccountSettingsController());
  }
}