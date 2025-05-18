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
          _buildFiltersRow(),
          const SizedBox(height: 20),
          _buildFeedbackTable(),
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
        Row(
          children: [
            _buildExportButton(),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }

  Widget _buildExportButton() {
    return OutlinedButton.icon(
      onPressed: () {
        // Export functionality
        Get.snackbar(
          'Export',
          'Exporting feedback data...',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      },
      icon: const Icon(Icons.download),
      label: const Text('Export'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        side: const BorderSide(color: Color(0xFF186CAC)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search feedback...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
          ),
          const SizedBox(width: 16),
          _buildDropdownFilter(
            'Type',
            ['All Types', 'Bug Report', 'Feature Request', 'General'],
                (value) {
              // Filter by type
            },
          ),
          const SizedBox(width: 16),
          _buildDropdownFilter(
            'Date',
            ['All Time', 'Today', 'This Week', 'This Month'],
                (value) {
              // Filter by date
            },
          ),
          const SizedBox(width: 16),
          _buildDropdownFilter(
            'Status',
            ['All Status', 'Unread', 'Read', 'Archived'],
                (value) {
              // Filter by status
            },
          ),
        ],
      ),
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

  Widget _buildFeedbackTable() {
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

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildDataTable(),
          ),
        );
      }),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      child: DataTable(
        columnSpacing: 20,
        headingRowColor: MaterialStateProperty.all(
          const Color(0xFFF9FAFB),
        ),
        dataRowMinHeight: 64,
        dataRowMaxHeight: 84,
        columns: const [
          DataColumn(
            label: Text(
              'TYPE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'FEEDBACK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'SUBMITTED BY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'DATE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'ACTIONS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: controller.feedbackList
            .map((feedback) => _buildDataRow(feedback))
            .toList(),
      ),
    );
  }

  DataRow _buildDataRow(FeedbackModel feedback) {
    return DataRow(
      cells: [
        DataCell(_buildFeedbackTypeChip(feedback.feedbackType)),
        DataCell(
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(
              feedback.feedbackContent,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          onTap: () => _showFeedbackDetails(feedback),
        ),
        DataCell(
          Text(feedback.isAnonymous ? 'Anonymous User' : 'Sender name: ${feedback.username ?? 'N/A'}'),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMM dd, yyyy').format(feedback.createdAt),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('hh:mm a').format(feedback.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility, color: Colors.blue),
                onPressed: () => _showFeedbackDetails(feedback),
                tooltip: 'View details',
              ),
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.green),
                onPressed: () => _copyFeedback(feedback.feedbackContent),
                tooltip: 'Copy feedback',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDelete(feedback.id),
                tooltip: 'Delete feedback',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackTypeChip(String type) {
    Color chipColor;
    IconData chipIcon;

    switch (type.toLowerCase()) {
      case 'bug report':
        chipColor = Colors.red[100]!;
        chipIcon = Icons.bug_report;
        break;
      case 'feature request':
        chipColor = Colors.green[100]!;
        chipIcon = Icons.lightbulb;
        break;
      case 'question':
        chipColor = Colors.blue[100]!;
        chipIcon = Icons.help;
        break;
      default:
        chipColor = Colors.grey[100]!;
        chipIcon = Icons.feedback;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(chipIcon, size: 16, color: Colors.black87),
          const SizedBox(width: 4),
          Text(
            type,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDetails(FeedbackModel feedback) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Feedback Details',
                    style: Theme.of(Get.context!).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const Divider(height: 30),
              _buildDetailRow('Type', _buildFeedbackTypeChip(feedback.feedbackType)),
              const SizedBox(height: 16),
              _buildDetailRow(
                'Submitted',
                Text(DateFormat('MMMM dd, yyyy - hh:mm a').format(feedback.createdAt)),
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                'User',
                Text(feedback.isAnonymous
                    ? 'Anonymous User'
                    : 'Sender name: ${feedback.username ?? 'N/A'}'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Feedback Content:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: SelectableText(feedback.feedbackContent),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _copyFeedback(feedback.feedbackContent),
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Content'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      _confirmDelete(feedback.id);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, Widget value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(child: value),
      ],
    );
  }

  void _copyFeedback(String content) {
    Clipboard.setData(ClipboardData(text: content));
    Get.snackbar(
      'Copied',
      'Feedback content copied to clipboard',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.only(top: 12, right: 12),
    );
  }

  void _confirmDelete(int id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Feedback'),
        content: const Text(
          'Are you sure you want to delete this feedback? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteFeedback(id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}