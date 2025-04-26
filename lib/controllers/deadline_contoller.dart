import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/deadline_model.dart';

class DeadlineController extends GetxController {
  var deadlines = <Deadline>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Mock data for demonstration (replace with actual API/database calls)
  void fetchDeadlines() async {
    try {
      isLoading(true);
      // Simulate API call or database fetch
      await Future.delayed(Duration(seconds: 1));
      deadlines.assignAll([
        Deadline(
          id: 14,
          title: 'Coursework 1',
          course: 'Artificial Intelligence',
          deadline: '2025-04-22 00:00:00',
          isCompleted: false,
          createdAt: '2025-04-17 11:27:15',
          updatedAt: '2025-04-17 11:27:15',
          year: '3rd Year',
          semester: 'Semester 2',
        ),
        Deadline(
          id: 15,
          title: 'Coursework 2',
          course: 'Application Development',
          deadline: '2025-04-22 00:00:00',
          isCompleted: false,
          createdAt: '2025-04-17 17:45:06',
          updatedAt: '2025-04-17 17:45:06',
          year: '3rd Year',
          semester: 'Semester 2',
        ),
      ]);
    } catch (e) {
      errorMessage('Failed to fetch deadlines: $e');
    } finally {
      isLoading(false);
    }
  }

  void postDeadline(Deadline deadline) async {
    try {
      isLoading(true);
      // Simulate API call or database insert
      await Future.delayed(Duration(seconds: 1));
      // Create a new Deadline instance with a mock ID
      deadlines.add(Deadline(
        id: deadlines.length + 14,
        title: deadline.title,
        course: deadline.course,
        deadline: deadline.deadline,
        isCompleted: deadline.isCompleted,
        createdAt: deadline.createdAt,
        updatedAt: deadline.updatedAt,
        year: deadline.year,
        semester: deadline.semester,
      ));
      Get.snackbar('Success', 'Deadline posted successfully');
          // backgroundColor: Color(0xFF042F6B), colorText: Colors.white);
    } catch (e) {
      errorMessage('Failed to post deadline: $e');
      Get.snackbar('Error', 'Failed to post deadline',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  void updateDeadline(Deadline deadline) async {
    try {
      isLoading(true);
      // Simulate API call or database update
      await Future.delayed(Duration(seconds: 1));
      final index = deadlines.indexWhere((d) => d.id == deadline.id);
      if (index != -1) {
        deadlines[index] = deadline;
        Get.snackbar('Success', 'Deadline updated successfully');
      }
    } catch (e) {
      errorMessage('Failed to update deadline: $e');
      Get.snackbar('Error', 'Failed to update deadline',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  void deleteDeadline(int id) async {
    try {
      isLoading(true);
      // Simulate API call or database delete
      await Future.delayed(Duration(seconds: 1));
      deadlines.removeWhere((d) => d.id == id);
      Get.snackbar('Success', 'Deadline deleted successfully',
          backgroundColor: Color(0xFF042F6B), colorText: Colors.white);
    } catch (e) {
      errorMessage('Failed to delete deadline: $e');
      Get.snackbar('Error', 'Failed to delete deadline',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}