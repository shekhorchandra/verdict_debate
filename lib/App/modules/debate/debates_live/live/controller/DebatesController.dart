import 'package:get/get.dart';

class DebatesController extends GetxController {
  var selectedTab = 1.obs; // 0: All, 1: Live Now, 2: Waiting

  void changeTab(int index) => selectedTab.value = index;

  // Mock data for the current live session
  final String topic = "Climate change requires immediate action";
  final String duration = "15 min";
  final int viewers = 452;
}
