class ChatMessage {
  final String text;
  final String time;
  final bool isMe;
  final String avatar;

  ChatMessage({
    required this.text,
    required this.time,
    required this.isMe,
    required this.avatar,
  });
}