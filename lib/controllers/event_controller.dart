import 'dart:convert';
import 'package:admin_panel/constants/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/events_model.dart';
import 'login_controller.dart';

class EventPostingController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var events = <Event>[].obs;

  final LoginController loginController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> postEvent(Event event) async {
    isLoading(true);
    errorMessage.value = '';
    successMessage.value = '';

    try {
      Uri url = Uri.parse(ApiEndpoints.postEvents);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginController.token.value}',
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(event.toJson()),
      );

      if (response.statusCode == 201) {
        successMessage.value = 'Event created successfully!';
        Get.snackbar('Event Posted', 'Event posted successfully');
        fetchEvents();
      } else {
        Get.snackbar('Failed to create event', 'Events cannot be in the past');
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchEvents() async {
    isLoading(true);
    errorMessage.value = '';

    try {
      Uri uri = Uri.parse(ApiEndpoints.getEvents);
      Map<String, String> headers = {
        'Authorization': 'Bearer ${loginController.token.value}',
        'Content-Type': 'application/json',
      };
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        events.value = jsonResponse.map((event) => Event.fromJson(event)).toList();
      } else {
        errorMessage.value = 'Failed to load events: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}