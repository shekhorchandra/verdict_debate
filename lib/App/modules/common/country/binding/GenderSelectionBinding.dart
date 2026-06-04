import 'package:get/get.dart';
import '../controller/GenderSelectionController.dart';

class GenderSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenderSelectionController>(() => GenderSelectionController());
  }
}