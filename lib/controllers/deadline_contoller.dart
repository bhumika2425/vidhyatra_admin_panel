// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/deadline_model.dart';
//
// class DeadlineController extends GetxController {
//   var deadlines = <Deadline>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//
//   // Mock data for demonstration (replace with actual API/database calls)
//   void fetchDeadlines() async {
//     try {
//       isLoading(true);
//       // Simulate API call or database fetch
//       await Future.delayed(Duration(seconds: 1));
//       deadlines.assignAll([
//         Deadline(
//           id: 14,
//           title: 'Coursework 1',
//           course: 'Artificial Intelligence',
//           deadline: '2025-04-22 00:00:00',
//           isCompleted: false,
//           createdAt: '2025-04-17 11:27:15',
//           updatedAt: '2025-04-17 11:27:15',
//           year: '3rd Year',
//           semester: 'Semester 2',
//         ),
//         Deadline(
//           id: 15,
//           title: 'Coursework 2',
//           course: 'Application Development',
//           deadline: '2025-04-22 00:00:00',
//           isCompleted: false,
//           createdAt: '2025-04-17 17:45:06',
//           updatedAt: '2025-04-17 17:45:06',
//           year: '3rd Year',
//           semester: 'Semester 2',
//         ),
//       ]);
//     } catch (e) {
//       errorMessage('Failed to fetch deadlines: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void postDeadline(Deadline deadline) async {
//     try {
//       isLoading(true);
//       // Simulate API call or database insert
//       await Future.delayed(Duration(seconds: 1));
//       // Create a new Deadline instance with a mock ID
//       deadlines.add(Deadline(
//         id: deadlines.length + 14,
//         title: deadline.title,
//         course: deadline.course,
//         deadline: deadline.deadline,
//         isCompleted: deadline.isCompleted,
//         createdAt: deadline.createdAt,
//         updatedAt: deadline.updatedAt,
//         year: deadline.year,
//         semester: deadline.semester,
//       ));
//       Get.snackbar('Success', 'Deadline posted successfully');
//           // backgroundColor: Color(0xFF042F6B), colorText: Colors.white);
//     } catch (e) {
//       errorMessage('Failed to post deadline: $e');
//       Get.snackbar('Error', 'Failed to post deadline',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void updateDeadline(Deadline deadline) async {
//     try {
//       isLoading(true);
//       // Simulate API call or database update
//       await Future.delayed(Duration(seconds: 1));
//       final index = deadlines.indexWhere((d) => d.id == deadline.id);
//       if (index != -1) {
//         deadlines[index] = deadline;
//         Get.snackbar('Success', 'Deadline updated successfully');
//       }
//     } catch (e) {
//       errorMessage('Failed to update deadline: $e');
//       Get.snackbar('Error', 'Failed to update deadline',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void deleteDeadline(int id) async {
//     try {
//       isLoading(true);
//       // Simulate API call or database delete
//       await Future.delayed(Duration(seconds: 1));
//       deadlines.removeWhere((d) => d.id == id);
//       Get.snackbar('Success', 'Deadline deleted successfully',
//           backgroundColor: Color(0xFF042F6B), colorText: Colors.white);
//     } catch (e) {
//       errorMessage('Failed to delete deadline: $e');
//       Get.snackbar('Error', 'Failed to delete deadline',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

import 'package:admin_panel/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/deadline_model.dart';

class DeadlineController extends GetxController {
  var deadlines = <Deadline>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final LoginController loginController = Get.find<LoginController>();

  static const String baseUrl = 'http://localhost:3001/api/deadlines';

  // // Fetch deadlines from API
  // void fetchDeadlines() async {
  //   try {
  //     isLoading(true);
  //     errorMessage(''); // Clear any previous error messages
  //
  //     final response = await http.get(
  //       Uri.parse(baseUrl),
  //       headers: {'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${loginController.token.value}',
  //       }
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonData = json.decode(response.body);
  //       final List<Deadline> fetchedDeadlines = jsonData
  //           .map((json) => Deadline.fromJson(json))
  //           .toList();
  //
  //       deadlines.assignAll(fetchedDeadlines);
  //     } else {
  //       errorMessage('Failed to fetch deadlines. Status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     errorMessage('Failed to fetch deadlines: $e');
  //     print('Error fetching deadlines: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }
// Fetch deadlines from API
  void fetchDeadlines() async {
    try {
      print('Fetching deadlines...'); // Debug: Start of fetch
      isLoading(true);
      errorMessage(''); // Clear any previous error messages

      final url = Uri.parse('http://localhost:3001/api/deadlines/admin/all');
      print('Request URL: $url'); // Debug: URL

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginController.token.value}',
      };
      print('Request Headers: $headers'); // Debug: Headers

      final response = await http.get(url, headers: headers);
      print('Response status: ${response.statusCode}'); // Debug: Status code
      print('Response body: ${response.body}'); // Debug: Raw response body

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('Decoded JSON data: $jsonData'); // Debug: Parsed JSON

        final List<Deadline> fetchedDeadlines = jsonData
            .map((json) => Deadline.fromJson(json))
            .toList();

        deadlines.assignAll(fetchedDeadlines);
        print('Fetched ${fetchedDeadlines.length} deadlines'); // Debug: Count
      } else {
        final msg = 'Failed to fetch deadlines. Status: ${response.statusCode}';
        errorMessage(msg);
        print(msg); // Debug: Error status
      }
    } catch (e) {
      final error = 'Failed to fetch deadlines: $e';
      errorMessage(error);
      print('Error fetching deadlines: $e'); // Debug: Exception
    } finally {
      isLoading(false);
      print('Fetching completed. isLoading = false'); // Debug: Final state
    }
  }

  // Post new deadline to API
  void postDeadline(Deadline deadline) async {
    try {
      isLoading(true);
      errorMessage(''); // Clear any previous error messages

      // Prepare the request body according to API format
      final Map<String, dynamic> requestBody = {
        'title': deadline.title,
        'course': deadline.course,
        'deadline': deadline.deadline,
        'year': deadline.year,
        'semester': deadline.semester,
      };

      final response = await http.post(
        Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json',
            'Authorization': 'Bearer ${loginController.token.value}',
          },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Extract the deadline object from the response
        final Deadline newDeadline = Deadline.fromJson(responseData['deadline']);

        // Add the new deadline to the list
        deadlines.add(newDeadline);

        Get.snackbar(
          'Success',
          responseData['message'] ?? 'Deadline created successfully',
          backgroundColor: Color(0xFF042F6B),
          colorText: Colors.white,
        );
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorMessage('Failed to create deadline: ${errorData['message'] ?? 'Unknown error'}');
        Get.snackbar(
          'Error',
          'Failed to create deadline',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage('Failed to post deadline: $e');
      Get.snackbar(
        'Error',
        'Failed to post deadline: Network error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error posting deadline: $e');
    } finally {
      isLoading(false);
    }
  }

  // Update deadline via API
  void updateDeadline(Deadline deadline) async {
    try {
      isLoading(true);
      errorMessage(''); // Clear any previous error messages

      // Prepare the request body according to API format
      final Map<String, dynamic> requestBody = {
        'title': deadline.title,
        'course': deadline.course,
        'deadline': deadline.deadline,
        'year': deadline.year,
        'semester': deadline.semester,
        'isCompleted': deadline.isCompleted,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/${deadline.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Update the deadline in the local list
        final index = deadlines.indexWhere((d) => d.id == deadline.id);
        if (index != -1) {
          // If the response contains the updated deadline, use it; otherwise use the passed deadline
          if (responseData.containsKey('deadline')) {
            deadlines[index] = Deadline.fromJson(responseData['deadline']);
          } else {
            deadlines[index] = deadline;
          }
        }

        Get.snackbar(
          'Success',
          responseData['message'] ?? 'Deadline updated successfully',
          backgroundColor: Color(0xFF042F6B),
          colorText: Colors.white,
        );
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorMessage('Failed to update deadline: ${errorData['message'] ?? 'Unknown error'}');
        Get.snackbar(
          'Error',
          'Failed to update deadline',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage('Failed to update deadline: $e');
      Get.snackbar(
        'Error',
        'Failed to update deadline: Network error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error updating deadline: $e');
    } finally {
      isLoading(false);
    }
  }

  // Delete deadline via API
  void deleteDeadline(int id) async {
    try {
      isLoading(true);
      errorMessage(''); // Clear any previous error messages

      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Remove the deadline from the local list
        deadlines.removeWhere((d) => d.id == id);

        final Map<String, dynamic> responseData = json.decode(response.body);
        Get.snackbar(
          'Success',
          responseData['message'] ?? 'Deadline deleted successfully',
          backgroundColor: Color(0xFF042F6B),
          colorText: Colors.white,
        );
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorMessage('Failed to delete deadline: ${errorData['message'] ?? 'Unknown error'}');
        Get.snackbar(
          'Error',
          'Failed to delete deadline',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage('Failed to delete deadline: $e');
      Get.snackbar(
        'Error',
        'Failed to delete deadline: Network error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error deleting deadline: $e');
    } finally {
      isLoading(false);
    }
  }
}