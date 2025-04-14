import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard functionality
import 'package:get/get.dart';
import '../controllers/feedback_controller.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';
import 'package:admin_panel/models/feedback_model.dart' as CustomFeedback; // Alias for Feedback model

class FeedbackPage extends StatelessWidget {
  final FeedbackController controller = Get.put(FeedbackController());

  FeedbackPage({super.key});

  void _showUpdateFeedbackDialog(BuildContext context, CustomFeedback.Feedback feedback) {
    final contentController = TextEditingController(text: feedback.feedbackContent);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Feedback'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Feedback Content'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Update feedback logic here (placeholder)
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF971F20)),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteFeedback(BuildContext context, int feedbackId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Feedback"),
        content: const Text("Are you sure you want to delete this feedback?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // controller.deleteFeedback(feedbackId); // Uncomment when logic is ready
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF971F20)),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _copyFeedbackContent(String content) {
    Clipboard.setData(ClipboardData(text: content));
    Get.snackbar('Copied', 'Feedback content copied to clipboard',
        backgroundColor: Colors.green, colorText: Colors.white, duration: const Duration(seconds: 2));
  }

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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Feedback",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.errorMessage.isNotEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)),
                              ElevatedButton(
                                onPressed: () => controller.fetchFeedback(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      if (controller.feedbackList.isEmpty) {
                        return const Center(child: Text('No feedback found'));
                      }
                      return RefreshIndicator(
                        onRefresh: controller.fetchFeedback,
                        child: ListView.builder(
                          itemCount: controller.feedbackList.length,
                          itemBuilder: (context, index) {
                            final feedback = controller.feedbackList[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                title: Text(
                                  feedback.feedbackType,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Content: ${feedback.feedbackContent}'),
                                    Text('Anonymous: ${feedback.isAnonymous == 1 ? 'Yes' : 'No'}'),
                                    Text('Posted on: ${feedback.timestamp}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () => _showUpdateFeedbackDialog(context, feedback),
                                      tooltip: 'Edit Feedback',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.copy, color: Colors.green),
                                      onPressed: () => _copyFeedbackContent(feedback.feedbackContent),
                                      tooltip: 'Copy Feedback',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _confirmDeleteFeedback(context, feedback.id),
                                      tooltip: 'Delete Feedback',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}