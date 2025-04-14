import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

import '../models/fees_model.dart';
import 'login_controller.dart';

// GetX controller for fees
class FeeController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var fees = <Fee>[].obs;
  var feePayments = <FeePayment>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load dummy data
    loadDummyData();
  }

  void loadDummyData() {
    // Simulate loading
    isLoading(true);

    // Add dummy fees
    fees.addAll([
      Fee(
        id: '1',
        feeType: 'Tuition Fee',
        description: 'First semester tuition fee',
        amount: 25000.0,
        dueDate: '2025-05-15',
        createdAt: '2025-04-01',
      ),
      Fee(
        id: '2',
        feeType: 'Library Fee',
        description: 'Annual library access fee',
        amount: 2000.0,
        dueDate: '2025-04-30',
        createdAt: '2025-04-01',
      ),
      Fee(
        id: '3',
        feeType: 'Examination Fee',
        description: 'End semester examination fee',
        amount: 1500.0,
        dueDate: '2025-05-20',
        createdAt: '2025-04-05',
      ),
    ]);

    // Add dummy fee payments
    feePayments.addAll([
      FeePayment(
        id: '1',
        studentName: 'John Doe',
        studentId: 'ST00123',
        feeType: 'Tuition Fee',
        amount: 25000.0,
        paymentDate: '2025-04-10',
        receiptNumber: 'REC-00123',
      ),
      FeePayment(
        id: '2',
        studentName: 'Jane Smith',
        studentId: 'ST00124',
        feeType: 'Library Fee',
        amount: 2000.0,
        paymentDate: '2025-04-05',
        receiptNumber: 'REC-00124',
      ),
      FeePayment(
        id: '3',
        studentName: 'Michael Johnson',
        studentId: 'ST00125',
        feeType: 'Tuition Fee',
        amount: 25000.0,
        paymentDate: '2025-04-12',
        receiptNumber: 'REC-00125',
      ),
      FeePayment(
        id: '4',
        studentName: 'Lisa Brown',
        studentId: 'ST00126',
        feeType: 'Examination Fee',
        amount: 1500.0,
        paymentDate: '2025-04-09',
        receiptNumber: 'REC-00126',
      ),
    ]);

    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading(false);
    });
  }

  // Method to add a new fee
  void addFee(Fee fee) {
    fees.add(fee);
    // In a real app, you would call an API here
  }
}