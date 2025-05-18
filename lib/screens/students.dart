import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/student_controller.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';

class StudentsPage extends StatelessWidget {
  final StudentsController controller = Get.put(StudentsController());

  StudentsPage({super.key});

  void _showUpdateStudentDialog(BuildContext context, student) {
    final nameController = TextEditingController(text: student.name);
    final emailController = TextEditingController(text: student.email);
    final collegeIdController = TextEditingController(text: student.collegeId);
    final roleController = TextEditingController(text: student.role);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Update Student'),
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
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF042F6B)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Update student logic here
                  Navigator.pop(context);
                  Get.snackbar(
                    'Success', // Title
                    'Student details updated successfully!', // Message
                    snackPosition:
                        SnackPosition.TOP, // You can also use SnackPosition.TOP
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF042F6B),
                  // Deep blue button background
                  foregroundColor: Colors.white, // White text color
                ),
                // style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF971F20)),
                child: const Text('Update'),
              ),
            ],
          ),
    );
  }

  void _confirmDeleteStudent(BuildContext context, int studentId) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Delete Student"),
            content: const Text(
              "Are you sure you want to delete this student?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xFF042F6B)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // controller.deleteStudent(studentId); // Uncomment when logic is ready
                  Navigator.pop(context);
                },
                // style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF971F20)),
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Students",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF042F6B).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Obx(
                          () => Text(
                            "${controller.students.length} Student${controller.students.length != 1 ? 's' : ''}",
                            style: TextStyle(
                              color: Color(0xFF042F6B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Header Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF042F6B),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "ID",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "College ID",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Text(
                        //     "Role",
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Actions",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF971F20),
                          ),
                        );
                      }
                      if (controller.errorMessage.isNotEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                controller.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.refresh),
                                onPressed: () => controller.fetchStudents(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF042F6B),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                label: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      if (controller.students.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No students found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: controller.fetchStudents,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: controller.students.length,
                            itemBuilder: (context, index) {
                              final student = controller.students[index];
                              final isEven = index % 2 == 0;

                              return Container(
                                decoration: BoxDecoration(
                                  color:
                                      isEven ? Colors.white : Colors.grey[50],
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      // ID
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "${student.userId}",
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                      // Name
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          student.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                      // Email
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          student.email,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                      // College ID
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          student.collegeId,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                      // Role
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Container(
                                      //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      //     decoration: BoxDecoration(
                                      //       color: Color(0xFF042F6B).withOpacity(0.1),
                                      //       borderRadius: BorderRadius.circular(12),
                                      //     ),
                                      //     child: Text(
                                      //       student.role,
                                      //       textAlign: TextAlign.center,
                                      //       style: TextStyle(
                                      //         color: Color(0xFF042F6B),
                                      //         fontWeight: FontWeight.w500,
                                      //         fontSize: 12,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Actions
                                      SizedBox(
                                        width: 120,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Color(0xFF042F6B),
                                                  size: 18,
                                                ),
                                              ),
                                              onPressed:
                                                  () =>
                                                      _showUpdateStudentDialog(
                                                        context,
                                                        student,
                                                      ),
                                              tooltip: "Edit Student",
                                            ),
                                            IconButton(
                                              icon: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                              ),
                                              onPressed:
                                                  () => _confirmDeleteStudent(
                                                    context,
                                                    student.userId,
                                                  ),
                                              tooltip: "Delete Student",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
