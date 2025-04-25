// import 'package:get/get.dart';
//
// import '../models/feedback_model.dart';
//
// class FeedbackController extends GetxController {
//   var feedbackList = <Feedback>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//
//   @override
//   void onInit() {
//     fetchFeedback();
//     super.onInit();
//   }
//
//   Future<void> fetchFeedback() async {
//     try {
//       isLoading.value = true;
//       // Replace with your API call
//       // var response = await http.get(Uri.parse('your-api-endpoint/feedback'));
//       // if (response.statusCode == 200) {
//       //   feedbackList.value = (jsonDecode(response.body) as List)
//       //       .map((e) => Feedback.fromJson(e))
//       //       .toList();
//       // } else {
//       //   throw Exception('Failed to fetch feedback');
//       // }
//
//       // For now, populate with sample data from your database
//       feedbackList.value = [
//         Feedback(
//           id: 11,
//           userId: 'cd293e6f43e5a500384f127e1ce82a1e:8689e8bc89d4b7a3f...',
//           feedbackType: 'courses',
//           feedbackContent: 'The course content is too basic.',
//           isAnonymous: 1,
//           timestamp: '2024-12-27 04:42:20',
//           createdAt: '2024-12-27 04:42:20',
//           updatedAt: '2024-12-27 04:42:20',
//         ),
//         Feedback(
//           id: 19,
//           userId: '455b807fd9a97c14306f8e0486a5bda0:317896e1d412f06d3...',
//           feedbackType: 'app_features',
//           feedbackContent: 'try2',
//           isAnonymous: 1,
//           timestamp: '2024-12-27 05:24:46',
//           createdAt: '2024-12-27 05:24:46',
//           updatedAt: '2024-12-27 05:24:46',
//         ),
//         // Add remaining feedback entries similarly...
//       ];
//     } catch (e) {
//       errorMessage.value = 'Failed to fetch feedback: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../models/feedback_model.dart';
import 'login_controller.dart';

class FeedbackController extends GetxController {
  var feedbackList = <FeedbackModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  final LoginController loginController = Get.find<LoginController>();

  @override
  void onInit() {
    fetchFeedback();
    super.onInit();
  }

  Future<void> fetchFeedback() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(ApiEndpoints.getFeedback);
      final token = loginController.token.value;
      print("fetch get feedback api= ${ApiEndpoints.getFeedback}");
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
          final feedbackData = jsonResponse['data'];
          if (feedbackData is List) {
            feedbackList.value = feedbackData.map((feedback) => FeedbackModel.fromJson(feedback as Map<String, dynamic>)).toList();
            successMessage.value = 'Feedback fetched successfully';
          } else {
            errorMessage.value = 'Data field is not a list';
          }
        } else {
          errorMessage.value = 'Invalid response format';
        }
      } else {
        errorMessage.value = 'Failed to load feedback: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching feedback: $e';
    } finally {
      isLoading.value = false;
    }
  }
}