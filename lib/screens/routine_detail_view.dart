// lib/views/routine_detail_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/routine_controller.dart';
import '../models/routine_model.dart';
import '../widgets/admin_top_navbar.dart';

class RoutineDetailView extends StatelessWidget {
  final int configId;
  final RoutineController controller = Get.find<RoutineController>();

  RoutineDetailView({required this.configId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AdminTopNavBar(),
      ),
      body: Container(
        color: Color(0xFFE9EDF2),
        child: FutureBuilder<RoutineConfig?>(
          future: controller.getRoutinesByConfigId(configId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error loading routine details"),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      child: Text("Go Back"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF042F6B),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                    ),
                  ],
                ),
              );
            }

            final routineConfig = snapshot.data!;
            return _buildRoutineDetailView(context, routineConfig);
          },
        ),
      ),
    );
  }

  Widget _buildRoutineDetailView(BuildContext context, RoutineConfig config) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with back button
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
              SizedBox(width: 10),
              Text(
                "Routine Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Routine Config Details
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Routine Configuration",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      _buildInfoItem("Faculty", config.faculty),
                      SizedBox(width: 30),
                      _buildInfoItem("Year", config.year),
                      SizedBox(width: 30),
                      _buildInfoItem("Semester", config.semester),
                      SizedBox(width: 30),
                      _buildInfoItem("Section", config.section),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),

          // Routine Entries By Day
          ...config.routinesByDay.entries.map((entry) {
            String day = entry.key;
            List<RoutineEntry> routines = entry.value;

            if (routines.isEmpty) {
              return SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
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
                                "Start Time",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "End Time",
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
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}