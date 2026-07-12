import 'package:get/get.dart';
import '../controller/CountryFilterController.dart';

class CountryFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountryFilterController>(() => CountryFilterController());
  }
}