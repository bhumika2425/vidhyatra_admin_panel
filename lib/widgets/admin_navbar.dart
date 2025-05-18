import 'package:admin_panel/screens/academic.dart';
import 'package:admin_panel/screens/dashboard.dart';
import 'package:admin_panel/screens/manage_deadline.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/event_management.dart';
import '../screens/feedback.dart';
import '../screens/fees.dart';
import '../screens/manage_routine.dart';
import '../screens/professors.dart';
import '../screens/students.dart';


class AdminNavBar extends StatelessWidget {
  final Function(int) onTap; // Callback function for navigation

  const AdminNavBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Color(0xFF053985),
        border: Border(
          top: BorderSide(
            color: Colors.white,  // You can change the color
            width: 3,            // You can set the width of the border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildNavItem(Icons.dashboard, "Dashboard", 0),
                _buildNavItem(Icons.chrome_reader_mode_outlined, "Manage Academics", 1),
                _buildNavItem(Icons.event, "Manage Events", 2),
                _buildNavItem(Icons.feedback, "User Feedback", 3),
                _buildNavItem(Icons.date_range_sharp, "Manage Routine", 4),
                _buildNavItem(Icons.schedule_outlined, "Deadline Posting", 5),
                _buildNavItem(Icons.supervisor_account_rounded, "Students", 6),
                _buildNavItem(Icons.account_box_rounded, "Professors", 7),
                _buildNavItem(Icons.money, "Fees", 8),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)
                  ),
                ),
                SizedBox(width: 15),
                Text('Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    return InkWell(
      onTap: () {
        onTap(index); // Call the onTap callback
        _navigateToPage(index); // Navigate to the respective page
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 15),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Get.to(() => AdminDashboard());
        break;
      case 1:
        Get.to(() => ManageAcademic());
        break;
      case 2:
      Get.to(() => ManageEvent());
      case 3:
        Get.to(() => FeedbackPage());
        break;
      case 4:
        Get.to(() => ManageRoutineView());
        break;
    case 5:
      Get.to(() => ManageDeadline());
      break;
      case 6:
        Get.to(() => StudentsPage());
        break;
      case 7:
        Get.to(() => ProfessorsPage());
        break;
      case 8:
        Get.to(() => FeesPage());
        break;
      default:
      // Get.to(() => DashboardPage()); // Default fallback to Dashboard
    }
  }
}