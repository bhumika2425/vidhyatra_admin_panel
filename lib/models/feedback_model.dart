class FeedbackModel {
  final int id;
  final String feedbackType;
  final String feedbackContent;
  final bool isAnonymous;
  final String username;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.feedbackType,
    required this.feedbackContent,
    required this.isAnonymous,
    required this.username,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      feedbackType: json['feedback_type'],
      feedbackContent: json['feedback_content'],
      isAnonymous: json['is_anonymous'] == 1 || json['is_anonymous'] == true,
      username: json['username'] ?? 'Anonymous',
      createdAt: DateTime.parse(json['createdAt'] ?? json['created_at']),
    );
  }
}