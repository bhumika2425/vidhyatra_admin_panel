import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/academic_model.dart';
import 'login_controller.dart';

class AcademicController extends GetxController {
  final events = <AcademicEvent>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final selectedEventType = 'EXAM'.obs;

  final LoginController loginController = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse('http://localhost:3001/api/academic/events'),
        headers: {
          'Authorization': 'Bearer ${loginController.token.value}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        events.value = (data['events'] as List)
            .map((event) => AcademicEvent.fromJson(event))
            .toList();
      } else {
        throw 'Failed to load events: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createEvent(AcademicEvent event) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.post(
        Uri.parse('http://localhost:3001/api/academic/events'),
        headers: {
          'Authorization': 'Bearer ${loginController.token.value}',
          'Content-Type': 'application/json',
        },
        body: json.encode(event.toJson()),
      );

      if (response.statusCode == 201) {
        await fetchEvents();
        Get.snackbar(
          'Success',
          'Event created successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw json.decode(response.body)['message'] ?? 'Failed to create event';
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}