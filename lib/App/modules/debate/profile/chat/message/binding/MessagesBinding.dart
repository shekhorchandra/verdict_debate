import 'package:get/get.dart';
import '../controller/MessagesController.dart';

class MessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagesController>(() => MessagesController());
  }
}