import 'dart:convert';
import 'package:admin_panel/constants/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/routine_model.dart';

class RoutineController extends GetxController {
  // Observable variables
  final selectedIndex = 0.obs;
  final showRoutineForm = false.obs;

  // Initial setup fields
  final selectedFaculty = Rx<String?>(null);
  final selectedYear = Rx<String?>(null);
  final selectedSemester = Rx<String?>(null);
  final selectedSection = Rx<String?>(null);

  // Routine entry fields
  final selectedDay = Rx<String?>(null);
  final selectedSubject = Rx<String?>(null);
  final selectedTeacher = Rx<String?>(null);
  final selectedRoom = Rx<String?>(null);
  final selectedStartTime = Rx<TimeOfDay?>(null);
  final selectedEndTime = Rx<TimeOfDay?>(null);

  // Map to store routine entries
  final routinesByDay = {
    'Sunday': <RoutineEntry>[].obs,
    'Monday': <RoutineEntry>[].obs,
    'Tuesday': <RoutineEntry>[].obs,
    'Wednesday': <RoutineEntry>[].obs,
    'Thursday': <RoutineEntry>[].obs,
    'Friday': <RoutineEntry>[].obs,
  }.obs;

  // Base URL for API (adjust to your backend URL)
  static const String baseUrl = '${ApiEndpoints.baseUrl}/api';

  // Computed property for checking if all days have routines
  bool get allDaysHaveRoutines {
    return routinesByDay.values.every((routines) => routines.isNotEmpty);
  }

  // Method to set navigation index
  void setNavIndex(int index) {
    selectedIndex.value = index;
  }

  // Create routine and show form
  void createRoutine() {
    if (selectedFaculty.value != null &&
        selectedYear.value != null &&
        selectedSemester.value != null &&
        selectedSection.value != null) {
      showRoutineForm.value = true;
    } else {
      Get.snackbar(
        'Incomplete Information',
        'Please select all fields first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // Add a new routine entry
  void addRoutineEntry() {
    if (selectedDay.value != null &&
        selectedSubject.value != null &&
        selectedTeacher.value != null &&
        selectedRoom.value != null &&
        selectedStartTime.value != null &&
        selectedEndTime.value != null) {
      final newEntry = RoutineEntry(
        subject: selectedSubject.value!,
        teacher: selectedTeacher.value!,
        room: selectedRoom.value!,
        startTime: selectedStartTime.value!.format(Get.context!),
        endTime: selectedEndTime.value!.format(Get.context!),
      );

      routinesByDay[selectedDay.value]!.add(newEntry);

      // Reset fields for next entry
      selectedSubject.value = null;
      selectedTeacher.value = null;
      selectedRoom.value = null;
      selectedStartTime.value = null;
      selectedEndTime.value = null;

      update();
    } else {
      Get.snackbar(
        'Incomplete Information',
        'Please fill all routine details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // Remove a routine entry
  void removeRoutineEntry(String day, int index) {
    routinesByDay[day]!.removeAt(index);
    update();
  }

  // Get complete routine configuration
  RoutineConfig getRoutineConfig() {
    return RoutineConfig(
      faculty: selectedFaculty.value!,
      year: selectedYear.value!,
      semester: selectedSemester.value!,
      section: selectedSection.value!,
      routinesByDay: Map.fromEntries(
          routinesByDay.entries
              .map((entry) => MapEntry(entry.key, entry.value))),
    );
  }

  // Select time
  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      if (isStartTime) {
        selectedStartTime.value = picked;
      } else {
        selectedEndTime.value = picked;
      }
    }
  }

  // Load routine configurations for sidebar
  Future<List<Map<String, String>>> getExistingRoutines() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/routines'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((item) => {
          'config_id': item['config_id'].toString(),
          'faculty': item['faculty'] as String,
          'year': item['year'] as String,
          'semester': item['semester'] as String,
          'section': item['section'] as String,
        })
            .toList();
      } else {
        throw Exception('Failed to fetch routines: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching routines: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch existing routines',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return [];
    }
  }

  // Fetch routines for a specific config_id
  Future<RoutineConfig?> getRoutinesByConfigId(int configId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/routines/$configId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final configData = data['config'];
        final routinesByDayData = data['routinesByDay'];

        // Convert routinesByDay to Map<String, List<RoutineEntry>>
        final routinesByDay = <String, List<RoutineEntry>>{};
        routinesByDayData.forEach((day, entries) {
          routinesByDay[day] = (entries as List)
              .map((entry) => RoutineEntry(
            subject: entry['subject'],
            teacher: entry['teacher'],
            room: entry['room'],
            startTime: entry['startTime'],
            endTime: entry['endTime'],
          ))
              .toList();
        });

        return RoutineConfig(
          faculty: configData['faculty'],
          year: configData['year'],
          semester: configData['semester'],
          section: configData['section'],
          routinesByDay: routinesByDay,
        );
      } else {
        throw Exception('Failed to fetch routines for config_id $configId: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching routines by config_id: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch routine details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return null;
    }
  }
  // Fetch existing routine configurations from backend
  // Future<List<Map<String, String>>> getExistingRoutines() async {
  //   try {
  //     final response = await http.get(Uri.parse('$baseUrl/routines'));
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       return data
  //           .map((item) => {
  //         'config_id': item['config_id'].toString(),
  //         'faculty': item['faculty'] as String,
  //         'year': item['year'] as String,
  //         'semester': item['semester'] as String,
  //         'section': item['section'] as String,
  //       })
  //           .toList();
  //     } else {
  //       throw Exception('Failed to fetch routines: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching routines: $e');
  //     Get.snackbar(
  //       'Error',
  //       'Failed to fetch existing routines',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red.withOpacity(0.1),
  //       colorText: Colors.red,
  //     );
  //     return [];
  //   }
  // }
  //
  // // Fetch routines for a specific config_id
  // Future<RoutineConfig?> getRoutinesByConfigId(int configId) async {
  //   try {
  //     final response = await http.get(Uri.parse('$baseUrl/routines/$configId'));
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       final data = jsonDecode(response.body);
  //       final configData = data['config'];
  //       final routinesByDayData = data['routinesByDay'];
  //
  //       // Convert routinesByDay to List<RoutineEntry>
  //       final routinesByDay = <String, List<RoutineEntry>>{};
  //       routinesByDayData.forEach((day, entries) {
  //         routinesByDay[day] = (entries as List)
  //             .map((entry) => RoutineEntry(
  //           subject: entry['subject'],
  //           teacher: entry['teacher'],
  //           room: entry['room'],
  //           startTime: entry['startTime'],
  //           endTime: entry['endTime'],
  //         ))
  //             .toList();
  //       });
  //
  //       return RoutineConfig(
  //         faculty: configData['faculty'],
  //         year: configData['year'],
  //         semester: configData['semester'],
  //         section: configData['section'],
  //         routinesByDay: routinesByDay,
  //       );
  //     } else {
  //       throw Exception('Failed to fetch routines for config_id $configId: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching routines by config_id: $e');
  //     Get.snackbar(
  //       'Error',
  //       'Failed to fetch routine details',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red.withOpacity(0.1),
  //       colorText: Colors.red,
  //     );
  //     return null;
  //   }
  // }

  // Save routine data to backend
  Future<bool> saveRoutine(RoutineConfig routineConfig) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/routines'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(routineConfig.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to save routine: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saving routine: $e');
      Get.snackbar(
        'Error',
        'Failed to save routine',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }
  }

  // Submit final routine to backend
  void submitFinalRoutine() async {
    RoutineConfig config = getRoutineConfig();
    bool success = await saveRoutine(config);

    if (success) {
      Get.snackbar(
        'Success',
        'Routine submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      // Reset everything for a new routine
      showRoutineForm.value = false;
      selectedFaculty.value = null;
      selectedYear.value = null;
      selectedSemester.value = null;
      selectedSection.value = null;

      routinesByDay.forEach((day, routines) {
        routines.clear();
      });

      update();
    } else {
      Get.snackbar(
        'Error',
        'Failed to submit routine',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}