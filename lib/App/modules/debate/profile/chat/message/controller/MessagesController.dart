import 'package:get/get.dart';
import '../model/UserMessageModel.dart';

class MessagesController extends GetxController {
  // 0 for Inbox, 1 for Requests
  var selectedTab = 0.obs;

  // Mock Data for Inbox
  final inboxMessages = <UserMessageModel>[
    UserMessageModel(name: "Johan Liebert", message: "That was a insane debate_final_4 great points", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=1"),
    UserMessageModel(name: "Johan Liebert", message: "That was a insane debate_final_4 great points", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=2", unreadCount: 3),
    UserMessageModel(name: "Johan Liebert", message: "That was a insane debate_final_4 great points", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=3", unreadCount: 3),
    UserMessageModel(name: "Johan Liebert", message: "That was a insane debate_final_4 great points", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=4", unreadCount: 3),
    UserMessageModel(name: "Johan Liebert", message: "That was a insane debate_final_4 great points", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=5"),
  ].obs;

  // Mock Data for Requests
  final requestMessages = <UserMessageModel>[
    UserMessageModel(name: "Johan Liebert", message: "Send you a message", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=6"),
    UserMessageModel(name: "Johan Liebert", message: "Send you a message", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=7"),
    UserMessageModel(name: "Johan Liebert", message: "Send you a message", time: "12:45 AM", avatar: "https://i.pravatar.cc/150?u=8"),
  ].obs;

  void changeTab(int index) => selectedTab.value = index;
}