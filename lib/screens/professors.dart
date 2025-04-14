import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/professor_controller.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';

class ProfessorsPage extends StatelessWidget {
  final ProfessorController controller = Get.put(ProfessorController());

  ProfessorsPage({super.key});

  void _showUpdateProfessorDialog(BuildContext context, professor) {
    final nameController = TextEditingController(text: professor.name);
    final emailController = TextEditingController(text: professor.email);
    final collegeIdController = TextEditingController(text: professor.collegeId);
    final roleController = TextEditingController(text: professor.role);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Professor'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: collegeIdController, decoration: const InputDecoration(labelText: 'College ID')),
              TextField(controller: roleController, decoration: const InputDecoration(labelText: 'Role')),
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
              // Update professor logic here (unchanged as requested)
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF971F20)),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteProfessor(BuildContext context, int professorId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Professor"),
        content: const Text("Are you sure you want to delete this professor?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // controller.deleteProfessor(professorId); // Uncomment when logic is ready (unchanged as requested)
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF971F20)),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
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
                    "Professors",
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
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                title: Text(professor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email: ${professor.email}'),
                                    Text('College ID: ${professor.collegeId}'),
                                    Text('Role: ${professor.role}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () => _showUpdateProfessorDialog(context, professor),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _confirmDeleteProfessor(context, professor.userId),
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