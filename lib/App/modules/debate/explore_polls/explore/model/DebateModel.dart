class DebateModel {
  final String username;
  final String question;
  final String description;
  final String imageUrl;
  final int disagreePercent;
  final int agreePercent;

  DebateModel({
    required this.username,
    required this.question,
    required this.description,
    required this.imageUrl,
    required this.disagreePercent,
    required this.agreePercent,
  });
}