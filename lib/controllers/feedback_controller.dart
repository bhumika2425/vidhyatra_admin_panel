import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../models/feedback_model.dart';
import 'login_controller.dart';

class FeedbackController extends GetxController {
  final feedbackList = <FeedbackModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final LoginController loginController = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    fetchFeedbacks();
  }

  Future<void> fetchFeedbacks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = loginController.token.value;
      if (token.isEmpty) {
        throw 'Authentication token is missing';
      }

      final response = await http.get(
        Uri.parse(ApiEndpoints.getFeedback),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['feedbacks'] != null && data['feedbacks'] is List) {
          feedbackList.value = (data['feedbacks'] as List)
              .map((json) => FeedbackModel.fromJson(json))
              .toList();
        } else {
          throw 'Invalid response format';
        }
      } else {
        throw 'Failed to load feedbacks: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFeedback(int id) async {
    try {
      isLoading.value = true;
      final token = loginController.token.value;

      final response = await http.delete(
        Uri.parse('${ApiEndpoints.getFeedback}/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        feedbackList.removeWhere((feedback) => feedback.id == id);
        Get.snackbar('Success', 'Feedback deleted successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        throw 'Failed to delete feedback';
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}