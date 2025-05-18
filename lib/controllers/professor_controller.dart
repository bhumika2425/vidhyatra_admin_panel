import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';
import '../models/user_model.dart';
import 'login_controller.dart';

class ProfessorController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var professors = <User>[].obs;

  final LoginController loginController = Get.find<LoginController>(); // Use Get.find instead of Get.put

  @override
  void onInit() {
    super.onInit();
    fetchProfessor();
  }

  Future<void> fetchProfessor() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(ApiEndpoints.getProfessors);
      final token = loginController.token.value;
      if (token.isEmpty) {
        errorMessage.value = 'Authentication token is missing';
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
          final professorsData = jsonResponse['data'];

          if (professorsData is List) {
            try {
              professors.value = professorsData.map((professor) {
                return User.fromJson(professor as Map<String, dynamic>);
              }).toList();
              successMessage.value = 'professors fetched successfully';
            } catch (e) {
              errorMessage.value = 'Error parsing professors data: $e';
            }
          } else {
            errorMessage.value = 'Data field is not a list: ${professorsData.runtimeType}';

          }
        } else {
          errorMessage.value = 'Invalid response format: Expected object with "data" key';

        }
      } else {
        errorMessage.value = 'Failed to load professors: ${response.statusCode} - ${response.body}';

      }
    } catch (e) {
      errorMessage.value = 'Error fetching professors: $e';

    } finally {
      isLoading.value = false;

    }
  }

  // Add professors method (was referenced but not implemented)
  Future<void> addProfessor(User professor) async {
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
        'collegeId': professor.collegeId,
        'name': professor.name,
        'email': professor.email,
        'role': professor.role,
      });

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchProfessor(); // Refresh the list
        successMessage.value = 'Professor added successfully';
      } else {
        errorMessage.value = 'Failed to add professor: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error adding professor: $e';
    } finally {
      isLoading.value = false;
    }
  }
}