import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../routes/app_routes.dart';
import '../controller/MessagesController.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0C1E),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 40, width: 40,
                  decoration: const BoxDecoration(color: Color(0xFF262450), shape: BoxShape.circle),
                  child: const Icon(Icons.chevron_left, color: Colors.white, size: 24),
                ),
              ),
            ),
          ),
          title: const Text("Messages", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [
            _buildSearchField(),
            TabBar(
              onTap: (index) => controller.changeTab(index),
              indicatorColor: const Color(0xFF8B8CF1),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.4),
              tabs: const [Tab(text: "Inbox"), Tab(text: "Requests")],
            ),
            const Divider(height: 1, color: Colors.white10),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMessageList(isInbox: true),
                  _buildMessageList(isInbox: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF262450).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF3B3870)),
        ),
        child: const TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search messages",
            hintStyle: TextStyle(color: Colors.white38),
            prefixIcon: Icon(Icons.search, color: Colors.white38),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }



  Widget _buildMessageList({required bool isInbox}) {
    return Obx(() {
      final messages = isInbox ? controller.inboxMessages : controller.requestMessages;

      return ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.white10),
        itemBuilder: (context, index) {
          final item = messages[index];
          return ListTile(
            // --- ADDED NAVIGATION HERE ---
            onTap: () {
              Get.toNamed(AppRoutes.CHAT_DETAILS, arguments: item);
            },
            // ------------------------------
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(item.avatar),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(item.time, style: const TextStyle(color: Color(0xFF8B8CF1), fontSize: 12)),
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    item.message,
                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Color(0xFF5E5BFB), shape: BoxShape.circle),
                    child: Text("${item.unreadCount}", style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
              ],
            ),
          );
        },
      );
    });
  }
}