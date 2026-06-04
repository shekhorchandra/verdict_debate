import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/ChatMessage.dart';
import '../../message/model/UserMessageModel.dart'; // Import your model

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Observable for the person we are chatting with
  var chatUser = Rxn<UserMessageModel>();

  final messages = <ChatMessage>[
    ChatMessage(
      text: "That was a insane debate great points!",
      time: "12:45 AM",
      isMe: false,
      avatar: "https://i.pravatar.cc/150?u=1",
    ),
    // ... rest of your mock data
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // 1. Capture the user passed from the previous screen
    if (Get.arguments != null && Get.arguments is UserMessageModel) {
      chatUser.value = Get.arguments as UserMessageModel;
    }
  }

  @override
  void onClose() {
    // 2. DISPOSE controllers to save memory
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      messages.add(ChatMessage(
        text: messageController.text.trim(),
        time: "12:46 AM",
        isMe: true,
        // In a real app, this would be YOUR avatar
        avatar: "https://i.pravatar.cc/150?u=my_id",
      ));

      messageController.clear();

      // Auto-scroll to bottom
      if (scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 100), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    }
  }
}