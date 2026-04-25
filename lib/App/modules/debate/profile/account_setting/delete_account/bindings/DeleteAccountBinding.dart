import 'package:get/get.dart';
import '../controller/DeleteAccountController.dart';

class DeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteAccountController>(() => DeleteAccountController());
  }
}