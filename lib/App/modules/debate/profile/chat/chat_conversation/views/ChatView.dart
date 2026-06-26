import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/ChatController.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Important for GlobalBackground
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("Today", style: TextStyle(color: Colors.white38, fontSize: 12)),
          ),

          Expanded(
            child: Obx(() => ListView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final msg = controller.messages[index];
                return _buildChatBubble(msg);
              },
            )),
          ),

          _buildInputBar(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: Color(0xFF818CF8), size: 30),
        onPressed: () => Get.back(),
      ),
      // Inside ChatView.dart -> _buildAppBar
      title: Obx(() => Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(controller.chatUser.value?.avatar ?? ""),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  controller.chatUser.value?.name ?? "Chat",
                  style: const TextStyle(color: Colors.white, fontSize: 16)
              ),
              const Text("Online", style: TextStyle(color: Colors.green, fontSize: 12)),
            ],
          ),
        ],
      )),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Color(0xFF818CF8)),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildChatBubble(msg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!msg.isMe) CircleAvatar(radius: 15, backgroundImage: NetworkImage(msg.avatar)),
          if (!msg.isMe) const SizedBox(width: 8),

          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: msg.isMe ? const Color(0xFF3F3D79) : const Color(0xFF252348),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
                  bottomRight: Radius.circular(msg.isMe ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(msg.text, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(msg.time, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                ],
              ),
            ),
          ),

          if (msg.isMe) const SizedBox(width: 8),
          if (msg.isMe) CircleAvatar(radius: 15, backgroundImage: NetworkImage(msg.avatar)),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF), // Light bluish background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: const InputDecoration(
                hintText: "Send Message",
                hintStyle: TextStyle(color: Colors.black38),
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.attach_file, color: Color(0xFF818CF8)),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1), // Send button color
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.near_me, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}