class Academic {
  int? examId;
  String title;
  String description;
  String venue;
  String examDate;
  String examStartTime;
  String examDuration;
  String year;
  int? createdBy;
  String createdAt;
  String updatedAt;

  Academic({
    this.examId,
    required this.title,
    required this.description,
    required this.venue,
    required this.examDate,
    required this.examStartTime,
    required this.examDuration,
    required this.year,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Academic.fromJson(Map<String, dynamic> json) {
    return Academic(
      examId: json['exam_id'],
      title: json['title'],
      description: json['description'],
      venue: json['venue'],
      examDate: json['exam_date'],
      examStartTime: json['exam_start_time'],
      examDuration: json['exam_duration'],
      year: json['year'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_id': examId,
      'title': title,
      'description': description,
      'venue': venue,
      'exam_date': examDate,
      'exam_start_time': examStartTime,
      'exam_duration': examDuration,
      'year': year,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}