class FeedbackModel {
  final int id;
  final String userId;
  final String feedbackType;
  final String feedbackContent;
  final int isAnonymous;
  final String timestamp;
  final String createdAt;
  final String updatedAt;
  final int rating; // Added for dashboard

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.feedbackType,
    required this.feedbackContent,
    required this.isAnonymous,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? '',
      feedbackType: json['feedbackType'] ?? '',
      feedbackContent: json['feedbackContent'] ?? '',
      isAnonymous: json['isAnonymous'] ?? 0,
      timestamp: json['timestamp'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'feedbackType': feedbackType,
      'feedbackContent': feedbackContent,
      'isAnonymous': isAnonymous,
      'timestamp': timestamp,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'rating': rating,
    };
  }
}