// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../models/academic_model.dart';
//
//
// class AcademicController extends GetxController {
//   var academics = <Academic>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//
//   // Fetch all academic calendar entries
//   Future<void> fetchAcademics() async {
//     try {
//       isLoading(true);
//       errorMessage('');
//
//       final response = await http.get(
//         Uri.parse(''),
//         headers: await _getHeaders(),
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body)['data'];
//         academics.value = jsonData.map((item) => Academic.fromJson(item)).toList();
//       } else {
//         errorMessage('Failed to load academic calendar: ${response.statusCode}');
//         print('Error: ${response.body}');
//       }
//     } catch (e) {
//       errorMessage('Error connecting to server: $e');
//       print('Exception: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // Post new academic calendar entry
//   Future<void> postAcademic(Academic academic) async {
//     try {
//       isLoading(true);
//       errorMessage('');
//
//       // Getting the admin ID from storage or state management
//       int adminId = await _getAdminId(); // Implement this method based on your auth system
//       academic.createdBy = adminId;
//
//       final response = await http.post(
//         Uri.parse(''),
//         headers: await _getHeaders(),
//         body: json.encode(academic.toJson()),
//       );
//
//       if (response.statusCode == 201) {
//         // Success - add to the observable list
//         final newAcademic = Academic.fromJson(json.decode(response.body)['data']);
//         academics.add(newAcademic);
//         Get.snackbar(
//             'Success',
//             'Academic calendar entry added successfully',
//             snackPosition: SnackPosition.BOTTOM,
//