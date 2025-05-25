// class Deadline {
//   int? id;
//   String title;
//   String course;
//   String deadline;
//   bool isCompleted;
//   String createdAt;
//   String updatedAt;
//   String year;
//   String semester;
//
//   Deadline({
//     this.id,
//     required this.title,
//     required this.course,
//     required this.deadline,
//     this.isCompleted = false,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.year,
//     required this.semester,
//   });
//
//   // Convert Deadline object to JSON for API or database
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'course': course,
//       'deadline': deadline,
//       'isCompleted': isCompleted ? 1 : 0,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'year': year,
//       'semester': semester,
//     };
//   }
//
//   // Create Deadline object from JSON
//   factory Deadline.fromJson(Map<String, dynamic> json) {
//     return Deadline(
//       id: json['id'],
//       title: json['title'],
//       course: json['course'],
//       deadline: json['deadline'],
//       isCompleted: json['isCompleted'] == 1,
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       year: json['year'],
//       semester: json['semester'],
//     );
//   }
// }
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

  // Convert Deadline object to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'course': course,
      'deadline': deadline,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'year': year,
      'semester': semester,
    };
  }

  // Create Deadline object from API JSON response
  factory Deadline.fromJson(Map<String, dynamic> json) {
    return Deadline(
      id: json['id'],
      title: json['title'] ?? '',
      course: json['course'] ?? '',
      deadline: json['deadline'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      year: json['year'] ?? '',
      semester: json['semester'] ?? '',
    );
  }

  // Create a copy of the deadline with updated fields
  Deadline copyWith({
    int? id,
    String? title,
    String? course,
    String? deadline,
    bool? isCompleted,
    String? createdAt,
    String? updatedAt,
    String? year,
    String? semester,
  }) {
    return Deadline(
      id: id ?? this.id,
      title: title ?? this.title,
      course: course ?? this.course,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      year: year ?? this.year,
      semester: semester ?? this.semester,
    );
  }
}