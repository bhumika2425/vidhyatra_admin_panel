class AcademicEvent {
  final int? id;
  final String title;
  final String description;
  final String eventType;
  final String? examType;
  final String? subject;
  final String? holidayType;
  final String startDate;
  final String endDate;
  final String? startTime;
  final int? duration;
  final String? venue;
  final String year;
  final String semester;
  final Creator? creator;

  AcademicEvent({
    this.id,
    required this.title,
    required this.description,
    required this.eventType,
    this.examType,
    this.subject,
    this.holidayType,
    required this.startDate,
    required this.endDate,
    this.startTime,
    this.duration,
    this.venue,
    required this.year,
    required this.semester,
    this.creator,
  });

  factory AcademicEvent.fromJson(Map<String, dynamic> json) {
    return AcademicEvent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      eventType: json['eventType'],
      examType: json['examType'],
      subject: json['subject'],
      holidayType: json['holidayType'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      duration: json['duration'],
      venue: json['venue'],
      year: json['year'],
      semester: json['semester'],
      creator: json['creator'] != null ? Creator.fromJson(json['creator']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'eventType': eventType,
      if (examType != null) 'examType': examType,
      if (subject != null) 'subject': subject,
      if (holidayType != null) 'holidayType': holidayType,
      'startDate': startDate,
      'endDate': endDate,
      if (startTime != null) 'startTime': startTime,
      if (duration != null) 'duration': duration,
      if (venue != null) 'venue': venue,
      'year': year,
      'semester': semester,
    };
  }
}

class Creator {
  final String name;
  final String email;

  Creator({required this.name, required this.email});

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      name: json['name'],
      email: json['email'],
    );
  }
}