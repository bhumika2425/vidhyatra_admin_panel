// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../controllers/feedback_controller.dart';
// import '../models/feedback_model.dart';
// import '../widgets/admin_navbar.dart';
// import '../widgets/admin_top_navbar.dart';
//
// class FeedbackPage extends StatelessWidget {
//   final FeedbackController controller = Get.put(FeedbackController());
//
//   FeedbackPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: AdminTopNavBar(),
//       ),
//       body: Row(
//         children: [
//           AdminNavBar(onTap: (index) {}),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(),
//                   const SizedBox(height: 20),
//                   _buildFeedbackList(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           "Feedback Management",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         ElevatedButton.icon(
//           onPressed: controller.fetchFeedbacks,
//           icon: const Icon(Icons.refresh),
//           label: const Text('Refresh'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF186CAC),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFeedbackList() {
//     return Expanded(
//       child: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.errorMessage.isNotEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   controller.errorMessage.value,
//                   style: const TextStyle(color: Colors.red),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: controller.fetchFeedbacks,
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         if (controller.feedbackList.isEmpty) {
//           return const Center(
//             child: Text('No feedbacks found', style: TextStyle(fontSize: 16)),
//           );
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.fetchFeedbacks,
//           child: ListView.builder(
//             itemCount: controller.feedbackList.length,
//             itemBuilder: (context, index) {
//               final feedback = controller.feedbackList[index];
//               return _buildFeedbackCard(feedback);
//             },
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildFeedbackCard(FeedbackModel feedback) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//       elevation: 3,
//       child: ExpansionTile(
//         title: Text(
//           feedback.feedbackType,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           DateFormat('MMM dd, yyyy HH:mm').format(feedback.createdAt),
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Feedback:',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(feedback.feedbackContent),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Anonymous: ${feedback.isAnonymous ? 'Yes' : 'No'}',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.copy, color: Colors.blue),
//                           onPressed: () => _copyFeedback(feedback.feedbackContent),
//                           tooltip: 'Copy feedback',
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _confirmDelete(feedback.id),
//                           tooltip: 'Delete feedback',
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _copyFeedback(String content) {
//     Clipboard.setData(ClipboardData(text: content));
//     Get.snackbar(
//       'Success',
//       'Feedback copied to clipboard',
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//       duration: const Duration(seconds: 2),
//     );
//   }
//
//   void _confirmDelete(int id) {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Delete Feedback'),
//         content: const Text('Are you sure you want to delete this feedback?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               controller.deleteFeedback(id);
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/feedback_controller.dart';
import '../models/feedback_model.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';

class FeedbackPage extends StatelessWidget {
  final FeedbackController controller = Get.put(FeedbackController());

  FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AdminTopNavBar(),
      ),
      body: Row(
        children: [
          AdminNavBar(onTap: (index) {}),
          Expanded(
            child: _buildFeedbackDashboard(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackDashboard() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDashboardHeader(),
          const SizedBox(height: 24),
          _buildFeedbackCards(),
        ],
      ),
    );
  }

  Widget _buildDashboardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Feedback Management",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Text(
              "${controller.feedbackList.length} feedback submissions",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownFilter(String hint, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        hint: Text(hint),
        underline: const SizedBox(),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildFeedbackCards() {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchFeedbacks,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.feedbackList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.feedback_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No feedback submissions found',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'New feedback will appear here when users submit them',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.feedbackList.length,
          itemBuilder: (context, index) {
            return _buildFeedbackCard(controller.feedbackList[index]);
          },
        );
      }),
    );
  }

  Widget _buildFeedbackCard(FeedbackModel feedback) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with type and date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeedbackTypeChip(feedback.feedbackType),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(feedback.createdAt),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('hh:mm a').format(feedback.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // User info
          Row(
            children: [
              Icon(
                feedback.isAnonymous ? Icons.person_off : Icons.person,
                size: 18,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                feedback.isAnonymous
                    ? 'Anonymous User'
                    : 'Sender name: ${feedback.username ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Feedback content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Text(
              feedback.feedbackContent,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackTypeChip(String type) {
    Color chipColor;
    Color textColor;
    IconData chipIcon;

    switch (type.toLowerCase()) {
      case 'bug report':
        chipColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        chipIcon = Icons.bug_report;
        break;
      case 'feature request':
        chipColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        chipIcon = Icons.lightbulb;
        break;
      case 'question':
        chipColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        chipIcon = Icons.help;
        break;
      default:
        chipColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
        chipIcon = Icons.feedback;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(chipIcon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            type,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}