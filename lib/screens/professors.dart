import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/professor_controller.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';

class ProfessorsPage extends StatelessWidget {
  final ProfessorController controller = Get.put(ProfessorController());

  ProfessorsPage({super.key});

  void _showAddProfessorDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final collegeIdController = TextEditingController();
    final roleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Professor'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: collegeIdController,
                decoration: const InputDecoration(labelText: 'College ID'),
              ),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(labelText: 'Role'),
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
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AdminTopNavBar(), // Top Navbar
      ),
      body: Row(
        children: [
          AdminNavBar(onTap: (index) {
            // Handle sidebar navigation if needed
          }),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Add title with same style as "Manage Events"
                const Text(
                  "Professors",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Display the list of professors
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
                              onPressed: () => controller.fetchProfessor(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                    if (controller.professors.isEmpty) {
                      return const Center(child: Text('No professors found'));
                    }
                    return RefreshIndicator(
                      onRefresh: controller.fetchProfessor,
                      child: ListView.builder(
                        itemCount: controller.professors.length,
                        itemBuilder: (context, index) {
                          final professor = controller.professors[index];
                          return ListTile(
                            title: Text(professor.name),
                            subtitle: Text(professor.email),
                            trailing: Text(professor.collegeId),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProfessorDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
