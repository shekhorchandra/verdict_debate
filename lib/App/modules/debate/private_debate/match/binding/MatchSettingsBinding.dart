import 'package:get/get.dart';
import '../controller/MatchSettingsController.dart';

class MatchSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchSettingsController>(() => MatchSettingsController());
  }
}