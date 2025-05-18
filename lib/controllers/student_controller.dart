import 'dart:convert';
import 'package:get/get.dart';
import '../../../../constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import 'login_controller.dart';

class StudentsController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var students = <User>[].obs;

  final LoginController loginController = Get.find<LoginController>(); // Use Get.find instead of Get.put

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(ApiEndpoints.getStudents);
      final token = loginController.token.value;


      if (token.isEmpty) {
        errorMessage.value = 'Authentication token is missing';
        print('Error: Token is empty');
        return;
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if response is a Map and contains 'data' key
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('data')) {
          final studentsData = jsonResponse['data'];

          if (studentsData is List) {
            try {
              students.value = studentsData.map((student) {

                return User.fromJson(student as Map<String, dynamic>);
              }).toList();
              successMessage.value = 'Students fetched successfully';
            } catch (e) {
              errorMessage.value = 'Error parsing students data: $e';

            }
          } else {
            errorMessage.value = 'Data field is not a list: ${studentsData.runtimeType}';

          }
        } else {
          errorMessage.value = 'Invalid response format: Expected object with "data" key';

        }
      } else {
        errorMessage.value = 'Failed to load students: ${response.statusCode} - ${response.body}';

      }
    } catch (e) {
      errorMessage.value = 'Error fetching students: $e';

    } finally {
      isLoading.value = false;

    }
  }

  // Add student method (was referenced but not implemented)
  Future<void> addStudent(User student) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(''); // Assuming this is the endpoint for adding users
      final token = loginController.token.value;

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = json.encode({
        'collegeId': student.collegeId,
        'name': student.name,
        'email': student.email,
        'role': student.role,
      });

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchStudents(); // Refresh the list
        successMessage.value = 'Student added successfully';
      } else {
        errorMessage.value = 'Failed to add student: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error adding student: $e';
    } finally {
      isLoading.value = false;
    }
  }
}