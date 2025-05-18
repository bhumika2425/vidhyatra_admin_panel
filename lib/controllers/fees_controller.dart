import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/fees_model.dart';
import 'login_controller.dart';

class FeeController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var fees = <Fee>[].obs;
  final LoginController loginController = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    fetchFees();
  }

  Future<void> fetchFees() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse('http://localhost:3001/api/collegeFees/fees');
      final token = loginController.token.value;

      if (token.isEmpty) {
        throw 'Authentication token is missing';
      }

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> feesList = json.decode(response.body);
        fees.value = feesList.map((fee) => Fee.fromJson(fee)).toList();
      } else {
        throw 'Failed to load fees: ${response.statusCode}';
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

  Future<void> addFee(Fee fee) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse('http://localhost:3001/api/collegeFees/fees');
      final token = loginController.token.value;

      if (token.isEmpty) {
        throw 'Authentication token is missing';
      }

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'feeType': fee.feeType,
          'feeDescription': fee.feeDescription,
          'feeAmount': fee.feeAmount,
          'dueDate': DateFormat('yyyy-MM-dd').format(fee.dueDate),
        }),
      );

      if (response.statusCode == 201) {
        await fetchFees();
        Get.snackbar(
          'Success',
          'Fee added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw 'Failed to add fee: ${response.statusCode}';
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