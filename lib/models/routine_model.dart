// // lib/models/routine_model.dart
//
// class RoutineEntry {
//   String subject;
//   String teacher;
//   String room;
//   String startTime;
//   String endTime;
//
//   RoutineEntry({
//     required this.subject,
//     required this.teacher,
//     required this.room,
//     required this.startTime,
//     required this.endTime,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'subject': subject,
//       'teacher': teacher,
//       'room': room,
//       'startTime': startTime,
//       'endTime': endTime,
//     };
//   }
//
//   factory RoutineEntry.fromJson(Map<String, dynamic> json) {
//     return RoutineEntry(
//       subject: json['subject'],
//       teacher: json['teacher'],
//       room: json['room'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//     );
//   }
// }
//
// class RoutineConfig {
//   String faculty;
//   String year;
//   String semester;
//   String section;
//   Map<String, List<RoutineEntry>> routinesByDay;
//
//   RoutineConfig({
//     required this.faculty,
//     required this.year,
//     required this.semester,
//     required this.section,
//     required this.routinesByDay,
//   });
//
//   bool get isComplete {
//     bool allDaysHaveRoutines = true;
//     routinesByDay.forEach((day, routines) {
//       if (routines.isEmpty) {
//         allDaysHaveRoutines = false;
//       }
//     });
//     return allDaysHaveRoutines;
//   }
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> routineMap = {};
//     routinesByDay.forEach((day, entries) {
//       routineMap[day] = entries.map((entry) => entry.toJson()).toList();
//     });
//
//     return {
//       'faculty': faculty,
//       'year': year,
//       'semester': semester,
//       'section': section,
//       'routinesByDay': routineMap,
//     };
//   }
// }

class RoutineEntry {
  String subject;
  String teacher;
  String room;
  String startTime;
  String endTime;

  RoutineEntry({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'teacher': teacher,
      'room': room,
      'startTime': startTime.replaceAll(' AM', ':00').replaceAll(' PM', ':00').padLeft(8, '0'),
      'endTime': endTime.replaceAll(' AM', ':00').replaceAll(' PM', ':00').padLeft(8, '0'),
    };
  }

  factory RoutineEntry.fromJson(Map<String, dynamic> json) {
    return RoutineEntry(
      subject: json['subject'],
      teacher: json['teacher'],
      room: json['room'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}

class RoutineConfig {
  String faculty;
  String year;
  String semester;
  String section;
  Map<String, List<RoutineEntry>> routinesByDay;

  RoutineConfig({
    required this.faculty,
    required this.year,
    required this.semester,
    required this.section,
    required this.routinesByDay,
  });

  bool get isComplete {
    return routinesByDay.values.every((routines) => routines.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> routineMap = {};
    routinesByDay.forEach((day, entries) {
      routineMap[day] = entries.map((entry) => entry.toJson()).toList();
    });

    return {
      'faculty': faculty,
      'year': year,
      'semester': semester,
      'section': section,
      'routinesByDay': routineMap,
    };
  }
}