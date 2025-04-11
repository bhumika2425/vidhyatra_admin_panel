import 'package:admin_panel/constants/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/admin_model.dart'; // Note: Assuming this is the correct file name

class LoginController extends GetxController {
  var isLoading = false.obs; // Observable for loading state
  var errorMessage = ''.obs; // Observable for error message
  var loggedInAdmin = Rxn<Admin>(); // Reactive nullable Admin
  var token = ''.obs; // Observable token as RxString

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    token.value = ''; // Reset token on new login attempt

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final admin = Admin.fromJson(data['admin']);
        token.value = data['token']; // Store token in RxString

        loggedInAdmin.value = admin;

        print('Token: ${token.value}'); // Debugging
        print('Logged in: ${admin.name}');

        Get.offNamed('/dashboard');
      } else {
        final data = jsonDecode(response.body);
        errorMessage.value = data['message'] ?? 'Login failed';
      }
    } catch (e) {
      errorMessage.value = 'Network error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}