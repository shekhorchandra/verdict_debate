import 'package:get/get.dart';
import '../controller/ArenaController.dart';


class ArenaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArenaController>(() => ArenaController());
  }
}