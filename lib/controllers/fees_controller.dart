import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../models/fees_model.dart';
import 'login_controller.dart';

class FeeController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var fees = <Fee>[].obs;
  var feePayments = <FeePayment>[].obs;

  final LoginController loginController = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    fetchFees();
    fetchFeePayments();
  }

  Future<void> fetchFees() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse("");
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
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('data')) {
          final feesData = jsonResponse['data'];
          if (feesData is List) {
            fees.value = feesData.map((fee) => Fee.fromJson(fee as Map<String, dynamic>)).toList();
            successMessage.value = 'Fees fetched successfully';
          } else {
            errorMessage.value = 'Data field is not a list';
          }
        } else {
          errorMessage.value = 'Invalid response format';
        }
      } else {
        errorMessage.value = 'Failed to load fees: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching fees: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFeePayments() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse("");
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
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('data')) {
          final paymentsData = jsonResponse['data'];
          if (paymentsData is List) {
            feePayments.value = paymentsData.map((payment) => FeePayment.fromJson(payment as Map<String, dynamic>)).toList();
            successMessage.value = 'Fee payments fetched successfully';
          } else {
            errorMessage.value = 'Data field is not a list';
          }
        } else {
          errorMessage.value = 'Invalid response format';
        }
      } else {
        errorMessage.value = 'Failed to load fee payments: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching fee payments: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addFee(Fee fee) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse("");
      final token = loginController.token.value;

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = json.encode(fee.toJson());

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchFees();
        successMessage.value = 'Fee added successfully';
      } else {
        errorMessage.value = 'Failed to add fee: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error adding fee: $e';
    } finally {
      isLoading.value = false;
    }
  }
}