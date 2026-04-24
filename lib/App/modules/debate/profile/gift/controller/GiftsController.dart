import 'package:get/get.dart';

class GiftsController extends GetxController {
  var selectedTab = 0.obs; // 0: Received Gifts, 1: My Gift Box

  final List<Map<String, dynamic>> giftInventory = [
    {"name": "Microphone", "count": "3x", "icon": "🎤"},
    {"name": "Megaphone", "count": "0x", "icon": "📢"},
    {"name": "Boxing Glove", "count": "7x", "icon": "🥊"},
    {"name": "Crown", "count": "5x", "icon": "👑"},
    {"name": "Lightning Bolt", "count": "11x", "icon": "⚡"},
    {"name": "Muscular Cow", "count": "1x", "icon": "🐂"},
  ];

  void changeTab(int index) => selectedTab.value = index;
}