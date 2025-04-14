// // lib/views/manage_routine_view.dart
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/routine_controller.dart';
// import '../widgets/admin_navbar.dart';
// import '../widgets/admin_top_navbar.dart';
//
// class ManageRoutineView extends StatelessWidget {
//   final RoutineController controller = Get.put(RoutineController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: AdminTopNavBar(),
//       ),
//       body: Container(
//         color: Color(0xFFE9EDF2),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           // Align row children at the top
//           children: [
//             AdminNavBar(onTap: (index) => controller.setNavIndex(index)),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: _buildRoutineContent(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRoutineContent(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start, // Align content at the top
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Routine Management",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//           ),
//           // Initial Setup Form - Optimized for Web
//           _buildClassInfoCard(context),
//           SizedBox(height: 20),
//           // Routine Entry Form
//           _buildRoutineEntryForm(context),
//           // Display Routine Entries by Day
//           _buildRoutineDayViews(context),
//           // Submit Button
//           _buildSubmitButton(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildClassInfoCard(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Class Information",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           SizedBox(height: 15),
//           Obx(
//             () => SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   _buildStyledDropdown(
//                     value: controller.selectedFaculty.value,
//                     hint: "Select Faculty",
//                     items: ["BBA", "BIT"],
//                     onChanged:
//                         (newValue) =>
//                             controller.selectedFaculty.value = newValue,
//                   ),
//                   SizedBox(width: 10), // Spacing between elements
//                   _buildStyledDropdown(
//                     value: controller.selectedYear.value,
//                     hint: "Select Year",
//                     items: ["1st Year", "2nd Year", "3rd Year"],
//                     onChanged:
//                         (newValue) => controller.selectedYear.value = newValue,
//                   ),
//                   SizedBox(width: 10),
//                   _buildStyledDropdown(
//                     value: controller.selectedSemester.value,
//                     hint: "Select Semester",
//                     items: ["Semester 1", "Semester 2"],
//                     onChanged:
//                         (newValue) =>
//                             controller.selectedSemester.value = newValue,
//                   ),
//                   SizedBox(width: 10),
//                   _buildStyledDropdown(
//                     value: controller.selectedSection.value,
//                     hint: "Select Section",
//                     items: [
//                       "C1",
//                       "C2",
//                       "C3",
//                       "C4",
//                       "C5",
//                       "C6",
//                       "C7",
//                       "C8",
//                       "C9",
//                       "C10",
//                     ],
//                     onChanged:
//                         (newValue) =>
//                             controller.selectedSection.value = newValue,
//                   ),
//                   SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () => controller.createRoutine(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF042F6B),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Create Routine",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRoutineEntryForm(BuildContext context) {
//     return Obx(() {
//       if (!controller.showRoutineForm.value) {
//         return SizedBox.shrink();
//       }
//
//       return Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 0.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Add Routine Entry",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 SizedBox(height: 24),
//                 Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: [
//                     _buildStyledDropdown(
//                       value: controller.selectedDay.value,
//                       hint: "Select Day",
//                       items: [
//                         "Sunday",
//                         "Monday",
//                         "Tuesday",
//                         "Wednesday",
//                         "Thursday",
//                         "Friday",
//                       ],
//                       onChanged:
//                           (newValue) => controller.selectedDay.value = newValue,
//                       width: 200,
//                     ),
//                     _buildStyledDropdown(
//                       value: controller.selectedSubject.value,
//                       hint: "Select Subject",
//                       items: [
//                         "Application Development",
//                         "Artificial Intelligence",
//                         "Data & Web Dev",
//                         "Software Dev",
//                         "Fundamentals of Computing",
//                         "Advanced Programming",
//                       ],
//                       onChanged:
//                           (newValue) =>
//                               controller.selectedSubject.value = newValue,
//                       width: 250,
//                     ),
//                     _buildStyledDropdown(
//                       value: controller.selectedTeacher.value,
//                       hint: "Select Teacher",
//                       items: [
//                         "Prathiva Gurung",
//                         "Sandip Adhikari",
//                         "Sandeep Gurung",
//                         "Sandip Dhakal",
//                         "Amar Khanal",
//                       ],
//                       onChanged:
//                           (newValue) =>
//                               controller.selectedTeacher.value = newValue,
//                       width: 200,
//                     ),
//                     _buildStyledDropdown(
//                       value: controller.selectedRoom.value,
//                       hint: "Select Room",
//                       items: [
//                         "Nepal-Fewa",
//                         "Nepal-Tilicho",
//                         "Nepal-Rara",
//                         "UK-BigBen",
//                         "UK-Thames",
//                       ],
//                       onChanged:
//                           (newValue) =>
//                               controller.selectedRoom.value = newValue,
//                       width: 200,
//                     ),
//                     _buildTimePicker(
//                       selectedTime: controller.selectedStartTime.value,
//                       hint: "Select Start Time",
//                       onTap: () => controller.selectTime(context, true),
//                     ),
//                     _buildTimePicker(
//                       selectedTime: controller.selectedEndTime.value,
//                       hint: "Select End Time",
//                       onTap: () => controller.selectTime(context, false),
//                     ),
//                     SizedBox(
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () => controller.addRoutineEntry(),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF042F6B),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 15,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Text(
//                           "Add Entry",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//         ],
//       );
//     });
//   }
//
//   Widget _buildRoutineDayViews(BuildContext context) {
//     return Obx(() {
//       if (!controller.showRoutineForm.value) {
//         return SizedBox.shrink();
//       }
//
//       return Column(
//         children:
//             controller.routinesByDay.entries.map((entry) {
//               String day = entry.key;
//               List<dynamic> routines = entry.value;
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     day,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//
//                   if (routines.isEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 24.0),
//                       child: Text(
//                         "No routine entries added yet",
//                         style: TextStyle(
//                           fontStyle: FontStyle.italic,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     )
//                   else
//                     Card(
//                       elevation: 1,
//                       margin: EdgeInsets.only(bottom: 24),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                             color: Color(0xFF042F6B),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 5,
//                                   child: Text(
//                                     "Subject",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Text(
//                                     "Teacher",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "Room",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "Start",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "End",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     "",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           ...routines.asMap().entries.map((routineEntry) {
//                             int index = routineEntry.key;
//                             var routine = routineEntry.value;
//                             return Container(
//                               color:
//                                   index % 2 == 0
//                                       ? Colors.white
//                                       : Color(0xFFF5F5F5),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 12,
//                               ),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 5,
//                                     child: Text(routine.subject),
//                                   ),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Text(routine.teacher),
//                                   ),
//                                   Expanded(flex: 2, child: Text(routine.room)),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(routine.startTime),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(routine.endTime),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                       ),
//                                       onPressed:
//                                           () => controller.removeRoutineEntry(
//                                             day,
//                                             index,
//                                           ),
//                                       tooltip: 'Delete Entry',
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     ),
//                 ],
//               );
//             }).toList(),
//       );
//     });
//   }
//
//   Widget _buildSubmitButton(BuildContext context) {
//     return Obx(() {
//       if (!controller.showRoutineForm.value ||
//           !controller.allDaysHaveRoutines) {
//         return SizedBox.shrink();
//       }
//
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 24.0),
//           child: ElevatedButton(
//             onPressed: () => controller.submitFinalRoutine(),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF042F6B),
//               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               "Submit Final Routine",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _buildStyledDropdown({
//     required String? value,
//     required String hint,
//     required List<String> items,
//     required Function(String?) onChanged,
//     double width = 180,
//   }) {
//     return Container(
//       width: width,
//       padding: EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Text(
//             hint,
//             style: TextStyle(fontSize: 14, color: Colors.black54),
//           ),
//           onChanged: onChanged,
//           items:
//               items
//                   .map(
//                     (item) => DropdownMenuItem(
//                       value: item,
//                       child: Text(item, style: TextStyle(fontSize: 14)),
//                     ),
//                   )
//                   .toList(),
//           dropdownColor: Colors.white,
//           isExpanded: true,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTimePicker({
//     required TimeOfDay? selectedTime,
//     required String hint,
//     required Function() onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 180,
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               selectedTime != null ? selectedTime.format(Get.context!) : hint,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: selectedTime != null ? Colors.black : Colors.black54,
//               ),
//             ),
//             Icon(Icons.access_time, size: 16, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }
// }


// lib/views/manage_routine_view.dart

import 'package:admin_panel/screens/routine_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/routine_controller.dart';
import '../models/routine_model.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';


class ManageRoutineView extends StatelessWidget {
  final RoutineController controller = Get.put(RoutineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AdminTopNavBar(),
      ),
      body: Container(
        color: Color(0xFFE9EDF2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Navigation Bar
            AdminNavBar(onTap: (index) => controller.setNavIndex(index)),

            // Main Content Area (85% of remaining width)
            Expanded(
              flex: 85,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildRoutineContent(context),
              ),
            ),

            // Right Sidebar (15% of remaining width)
            Expanded(
              flex: 15,
              child: _buildRoutineConfigsList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutineConfigsList(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header
          Container(
            color: Color(0xFF042F6B),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: double.infinity,
            child: Text(
              "Saved Routines",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // List of routines
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: controller.getExistingRoutines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error loading routines"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No routines found"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final config = snapshot.data![index];
                      return _buildRoutineConfigItem(context, config);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildRoutineConfigItem(BuildContext context, Map<String, String> config) {
  //   return Card(
  //     margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  //     child: InkWell(
  //       onTap: () {
  //         // Add null check and validation before parsing
  //         if (config['config_id'] != null && config['config_id']!.isNotEmpty) {
  //           try {
  //             int configId = int.parse(config['config_id']!);
  //             Get.to(() => RoutineDetailView(configId: configId));
  //           } catch (e) {
  //             print('Error parsing config_id: ${config['config_id']}');
  //             Get.snackbar(
  //               'Error',
  //               'Invalid configuration ID',
  //               snackPosition: SnackPosition.BOTTOM,
  //               backgroundColor: Colors.red.withOpacity(0.1),
  //               colorText: Colors.red,
  //             );
  //           }
  //         }
  //       },
  //       child: Padding(
  //         padding: EdgeInsets.all(12),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "${config['faculty']} - ${config['year']}",
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 14,
  //               ),
  //             ),
  //             SizedBox(height: 4),
  //             Text(
  //               "${config['semester']} - Section ${config['section']}",
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: Colors.grey[700],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildRoutineConfigItem(BuildContext context, Map<String, String> config) {
    // Check if config_id exists and is not empty
    final configId = config['config_id'];
    final isValidConfigId = configId != null && configId.isNotEmpty;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: () {
          if (isValidConfigId) {
            try {
              int parsedConfigId = int.parse(configId);
              Get.to(() => RoutineDetailView(configId: parsedConfigId));
            } catch (e) {
              print('Error parsing config_id: $configId');
              Get.snackbar(
                'Error',
                'Invalid configuration ID',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withOpacity(0.1),
                colorText: Colors.red,
              );
            }
          } else {
            print('Missing or empty config_id');
            Get.snackbar(
              'Error',
              'Missing configuration ID',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.1),
              colorText: Colors.red,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${config['faculty'] ?? 'Unknown'} - ${config['year'] ?? 'Unknown'}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "${config['semester'] ?? 'Unknown'} - Section ${config['section'] ?? 'Unknown'}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoutineContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Routine Management",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          // Initial Setup Form - Optimized for Web
          _buildClassInfoCard(context),
          SizedBox(height: 20),
          // Routine Entry Form
          _buildRoutineEntryForm(context),
          // Display Routine Entries by Day
          _buildRoutineDayViews(context),
          // Submit Button
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildClassInfoCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Class Information",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 15),
          Obx(
                () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStyledDropdown(
                    value: controller.selectedFaculty.value,
                    hint: "Select Faculty",
                    items: ["BBA", "BIT"],
                    onChanged: (newValue) => controller.selectedFaculty.value = newValue,
                  ),
                  SizedBox(width: 10),
                  _buildStyledDropdown(
                    value: controller.selectedYear.value,
                    hint: "Select Year",
                    items: ["1st Year", "2nd Year", "3rd Year"],
                    onChanged: (newValue) => controller.selectedYear.value = newValue,
                  ),
                  SizedBox(width: 10),
                  _buildStyledDropdown(
                    value: controller.selectedSemester.value,
                    hint: "Select Semester",
                    items: ["Semester 1", "Semester 2"],
                    onChanged: (newValue) => controller.selectedSemester.value = newValue,
                  ),
                  SizedBox(width: 10),
                  _buildStyledDropdown(
                    value: controller.selectedSection.value,
                    hint: "Select Section",
                    items: ["C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10"],
                    onChanged: (newValue) => controller.selectedSection.value = newValue,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => controller.createRoutine(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF042F6B),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Create Routine",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineEntryForm(BuildContext context) {
    return Obx(() {
      if (!controller.showRoutineForm.value) {
        return SizedBox.shrink();
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Routine Entry",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 24),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildStyledDropdown(
                      value: controller.selectedDay.value,
                      hint: "Select Day",
                      items: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
                      onChanged: (newValue) => controller.selectedDay.value = newValue,
                      width: 200,
                    ),
                    _buildStyledDropdown(
                      value: controller.selectedSubject.value,
                      hint: "Select Subject",
                      items: [
                        "Application Development",
                        "Artificial Intelligence",
                        "Data & Web Dev",
                        "Software Dev",
                        "Fundamentals of Computing",
                        "Advanced Programming",
                      ],
                      onChanged: (newValue) => controller.selectedSubject.value = newValue,
                      width: 250,
                    ),
                    _buildStyledDropdown(
                      value: controller.selectedTeacher.value,
                      hint: "Select Teacher",
                      items: [
                        "Prathiva Gurung",
                        "Sandip Adhikari",
                        "Sandeep Gurung",
                        "Sandip Dhakal",
                        "Amar Khanal",
                      ],
                      onChanged: (newValue) => controller.selectedTeacher.value = newValue,
                      width: 200,
                    ),
                    _buildStyledDropdown(
                      value: controller.selectedRoom.value,
                      hint: "Select Room",
                      items: [
                        "Nepal-Fewa",
                        "Nepal-Tilicho",
                        "Nepal-Rara",
                        "UK-BigBen",
                        "UK-Thames",
                      ],
                      onChanged: (newValue) => controller.selectedRoom.value = newValue,
                      width: 200,
                    ),
                    _buildTimePicker(
                      selectedTime: controller.selectedStartTime.value,
                      hint: "Select Start Time",
                      onTap: () => controller.selectTime(context, true),
                    ),
                    _buildTimePicker(
                      selectedTime: controller.selectedEndTime.value,
                      hint: "Select End Time",
                      onTap: () => controller.selectTime(context, false),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => controller.addRoutineEntry(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF042F6B),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          "Add Entry",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    });
  }

  Widget _buildRoutineDayViews(BuildContext context) {
    return Obx(() {
      if (!controller.showRoutineForm.value) {
        return SizedBox.shrink();
      }

      return Column(
        children: controller.routinesByDay.entries.map((entry) {
          String day = entry.key;
          List<dynamic> routines = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),

              if (routines.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "No routine entries added yet",
                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                )
              else
                Card(
                  elevation: 1,
                  margin: EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        color: Color(0xFF042F6B),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                "Subject",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Teacher",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Room",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Start",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "End",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...routines.asMap().entries.map((routineEntry) {
                        int index = routineEntry.key;
                        var routine = routineEntry.value;
                        return Container(
                          color: index % 2 == 0 ? Colors.white : Color(0xFFF5F5F5),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(flex: 5, child: Text(routine.subject)),
                              Expanded(flex: 3, child: Text(routine.teacher)),
                              Expanded(flex: 2, child: Text(routine.room)),
                              Expanded(flex: 2, child: Text(routine.startTime)),
                              Expanded(flex: 2, child: Text(routine.endTime)),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => controller.removeRoutineEntry(day, index),
                                  tooltip: 'Delete Entry',
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
            ],
          );
        }).toList(),
      );
    });
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Obx(() {
      if (!controller.showRoutineForm.value || !controller.allDaysHaveRoutines) {
        return SizedBox.shrink();
      }

      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: ElevatedButton(
            onPressed: () => controller.submitFinalRoutine(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF042F6B),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              "Submit Final Routine",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildStyledDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
    double width = 180,
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          onChanged: onChanged,
          items: items
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item, style: TextStyle(fontSize: 14)),
          ))
              .toList(),
          dropdownColor: Colors.white,
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required TimeOfDay? selectedTime,
    required String hint,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTime != null ? selectedTime.format(Get.context!) : hint,
              style: TextStyle(
                fontSize: 14,
                color: selectedTime != null ? Colors.black : Colors.black54,
              ),
            ),
            Icon(Icons.access_time, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}