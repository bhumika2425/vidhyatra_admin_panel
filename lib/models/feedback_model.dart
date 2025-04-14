class Feedback {
  final int id;
  final String userId;
  final String feedbackType;
  final String feedbackContent;
  final int isAnonymous;
  final String timestamp;
  final String createdAt;
  final String updatedAt;

  Feedback({
    required this.id,
    required this.userId,
    required this.feedbackType,
    required this.feedbackContent,
    required this.isAnonymous,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create Feedback from JSON (if using API)
  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'],
      userId: json['user_id'],
      feedbackType: json['feedback_type'],
      feedbackContent: json['feedback_content'],
      isAnonymous: json['is_anonymous'],
      timestamp: json['timestamp'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}