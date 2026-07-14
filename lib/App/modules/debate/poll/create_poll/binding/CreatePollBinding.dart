import 'package:get/get.dart';
import '../controller/CreatePollController.dart';

class CreatePollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePollController>(() => CreatePollController());
  }
}