class Deadline {
  int? id;
  String title;
  String course;
  String deadline;
  bool isCompleted;
  String createdAt;
  String updatedAt;
  String year;
  String semester;

  Deadline({
    this.id,
    required this.title,
    required this.course,
    required this.deadline,
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
    required this.year,
    required this.semester,
  });

  // Convert Deadline object to JSON for API or database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'course': course,
      'deadline': deadline,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'year': year,
      'semester': semester,
    };
  }

  // Create Deadline object from JSON
  factory Deadline.fromJson(Map<String, dynamic> json) {
    return Deadline(
      id: json['id'],
      title: json['title'],
      course: json['course'],
      deadline: json['deadline'],
      isCompleted: json['isCompleted'] == 1,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      year: json['year'],
      semester: json['semester'],
    );
  }
}