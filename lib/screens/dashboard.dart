import 'package:admin_panel/models/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/admin_dashboard_controller.dart';
import '../controllers/event_controller.dart';

import '../controllers/feedback_controller.dart';

import '../controllers/fees_controller.dart';
import '../controllers/professor_controller.dart';
import '../controllers/routine_controller.dart';
import '../controllers/student_controller.dart';

import '../models/user_model.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AdminDashboardController adminController = Get.put(AdminDashboardController());
  final EventPostingController eventController = Get.put(EventPostingController());
  final FeedbackController feedbackController = Get.put(FeedbackController());
  final FeeController feeController = Get.put(FeeController());
  final ProfessorController professorController = Get.put(ProfessorController());
  final RoutineController routineController = Get.put(RoutineController());
  final StudentsController studentsController = Get.put(StudentsController());

  int selectedIndex = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _onNavItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AdminTopNavBar(),
      ),
      body: Container(
        color: Color(0xFFF5F7FA),
        child: Row(
          children: [
            AdminNavBar(onTap: _onNavItemSelected),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildDashboardContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWelcomeSection(),
        SizedBox(height: 24),
        _buildQuickStats(),
        SizedBox(height: 24),
        _buildAnalyticsSection(),
        SizedBox(height: 24),
        _buildManagementSection(),
        SizedBox(height: 24),
        _buildCalendarAndNotifications(),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Obx(() {
      final overdueFees = feeController.fees.where((fee) {
        final dueDate = DateTime.parse(fee.dueDate);
        return dueDate.isBefore(DateTime.now());
      }).length;

      // Assume students need review if recently added (no applicationStatus)
      final pendingApplications = studentsController.students
          .where((student) => student.createdAt.isAfter(DateTime.now().subtract(Duration(days: 30))))
          .length;

      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Admin',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Here\'s what\'s happening at your college today',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      // _buildAlertCard(
                      //   'Fee Payment Due',
                      //   '$overdueFees students have overdue fees',
                      //   Icons.warning_amber_rounded,
                      //   Color(0xFFFEF3C7),
                      //   Color(0xFFD97706),
                      // ),
                      SizedBox(width: 12),
                      // _buildAlertCard(
                      //   'Pending Applications',
                      //   '$pendingApplications new applications need review',
                      //   Icons.person_add_alt_rounded,
                      //   Color(0xFFE0F2FE),
                      //   Color(0xFF0369A1),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Schedule',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF334155),
                      ),
                    ),
                    SizedBox(height: 12),
                    Obx(() {
                      final today = DateTime.now().weekday;
                      final dayName = [
                        'Sunday',
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                      ][today - 1];
                      final routines = routineController.routinesByDay[dayName]?.take(3).toList() ?? [];
                      if (routines.isEmpty) {
                        return Text(
                          'No schedule for today',
                          style: TextStyle(color: Colors.grey[600]),
                        );
                      }
                      return Column(
                        children: routines.asMap().entries.map((entry) {
                          final routine = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: _buildScheduleItem(
                              routine.startTime,
                              routine.subject,
                              routine.room,
                              Color(0xFF4F46E5),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAlertCard(String title, String message, IconData icon, Color bgColor, Color iconColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 12,
                      color: iconColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String time, String title, String location, Color color) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 40,
          color: color,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF334155),
              ),
            ),
            Text(
              location,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Obx(() {
      final totalStudents = studentsController.students.length;
      final totalProfessors = professorController.professors.length;
      final unpaidFees = feeController.fees
          .where((fee) => DateTime.parse(fee.dueDate).isBefore(DateTime.now()))
          .fold(0.0, (sum, fee) => sum + fee.amount);
      final averageRating = feedbackController.feedbackList.isNotEmpty
          ? feedbackController.feedbackList
          .map((f) => f.rating)
          .reduce((a, b) => a + b) /
          feedbackController.feedbackList.length
          : 0.0;

      return Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Students',
              totalStudents.toString(),
              Colors.blue[700]!,
              Icons.people_alt_rounded,
              '${studentsController.students.where((s) => s.createdAt.year == DateTime.now().year).length} joined this year',
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Total Professors',
              totalProfessors.toString(),
              Colors.green[700]!,
              Icons.school_rounded,
              '${professorController.professors.where((p) => p.createdAt.year == DateTime.now().year).length} hired this year',
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Unpaid Fees',
              '\$${unpaidFees.toStringAsFixed(0)}',
              Colors.orange[700]!,
              Icons.account_balance_wallet_rounded,
              '${feeController.fees.where((fee) => DateTime.parse(fee.dueDate).isBefore(DateTime.now())).length} students overdue',
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'App Feedback',
              '${averageRating.toStringAsFixed(1)}/5',
              Colors.purple[700]!,
              Icons.thumbs_up_down_rounded,
              'Based on ${feedbackController.feedbackList.length} ratings',
            ),
          ),
        ],
      );
    });
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon, String subtitle) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              Icon(icon, color: color),
            ],
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Container(
      height: 320,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Student Registrations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              DropdownButton<String>(
                value: 'This Year',
                underline: SizedBox(),
                items: ['This Year', 'Last Year', 'All Time'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  // Implement filtering logic if needed
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Obx(() => _buildStudentJoinChart()),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentJoinChart() {
    final students = studentsController.students;
    if (students.isEmpty || studentsController.isLoading.value) {
      return Center(
        child: studentsController.isLoading.value
            ? CircularProgressIndicator()
            : Text('No student data available'),
      );
    }

    final currentYear = DateTime.now().year;
    final joinCounts = List.filled(12, 0);
    for (var student in students) {
      final joinDate = student.createdAt;
      if (joinDate.year == currentYear) {
        joinCounts[joinDate.month - 1]++;
      }
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const titles = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                final index = value.toInt();
                if (index >= 0 && index < titles.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                return Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: (joinCounts.reduce((a, b) => a > b ? a : b) + 10).toDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(12, (index) => FlSpot(index.toDouble(), joinCounts[index].toDouble())),
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Color(0xFF2563EB).withOpacity(0.5),
                Color(0xFF3B82F6).withOpacity(0.5),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: Color(0xFF2563EB),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2563EB).withOpacity(0.2),
                  Color(0xFF3B82F6).withOpacity(0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildStudentList(),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildProfessorList(),
        ),
      ],
    );
  }

  Widget _buildStudentList() {
    return Container(
      height: 350,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Student Applications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final recentStudents = studentsController.students
                  .where((s) => s.createdAt.isAfter(DateTime.now().subtract(Duration(days: 30))))
                  .take(5)
                  .toList();
              if (studentsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (recentStudents.isEmpty) {
                return Center(child: Text('No recent applications'));
              }
              return ListView.separated(
                itemCount: recentStudents.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  return _buildStudentApplicationItem(recentStudents[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessorList() {
    return Container(
      height: 350,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Professors',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final recentProfessors = professorController.professors.take(5).toList();
              if (professorController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (recentProfessors.isEmpty) {
                return Center(child: Text('No professors available'));
              }
              return ListView.separated(
                itemCount: recentProfessors.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  return _buildProfessorItem(recentProfessors[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentApplicationItem(User student) {
    // Assume pending status for recent students
    const status = 'Pending';
    const statusColor = Colors.orange;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      leading: CircleAvatar(
        backgroundColor: Color(0xFFF1F5F9),
        child: Text(
          student.name.substring(0, 1),
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        student.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Applied: ${student.createdAt.toString().substring(0, 10)}'),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildProfessorItem(User professor) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      leading: CircleAvatar(
        backgroundColor: Color(0xFFF1F5F9),
        child: Text(
          professor.name.substring(0, 1),
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        professor.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Hired: ${professor.createdAt.toString().substring(0, 10)}'),
      trailing: Text(
        professor.role,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildCalendarAndNotifications() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calendar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 16),
                Obx(() {
                  if (eventController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue[400],
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue[700],
                        shape: BoxShape.circle,
                      ),
                      markersMaxCount: 3,
                      outsideDaysVisible: false, // Reduce height by hiding outside days
                      cellMargin: EdgeInsets.all(4), // Optimize spacing
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      formatButtonTextStyle: TextStyle(fontSize: 14),
                      titleTextStyle: TextStyle(fontSize: 16),
                      leftChevronMargin: EdgeInsets.zero,
                      rightChevronMargin: EdgeInsets.zero,
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(fontSize: 12),
                      weekendStyle: TextStyle(fontSize: 12),
                    ),
                    eventLoader: (day) {
                      return eventController.events
                          .where((event) {
                        final eventDate = DateTime.parse(event.eventDate);
                        return eventDate.year == day.year &&
                            eventDate.month == day.month &&
                            eventDate.day == day.day;
                      })
                          .map((event) => event.title)
                          .toList();
                    },
                  );
                }),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            height: 380,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Feedback',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('View All'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    if (feedbackController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (feedbackController.feedbackList.isEmpty) {
                      return Center(child: Text('No feedback available'));
                    }
                    return ListView.separated(
                      itemCount: feedbackController.feedbackList.length > 4
                          ? 4
                          : feedbackController.feedbackList.length,
                      separatorBuilder: (context, index) => Divider(height: 24),
                      itemBuilder: (context, index) {
                        return _buildFeedbackItem(feedbackController.feedbackList[index]);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackItem(FeedbackModel feedback) {
    // Display userId or 'Anonymous' if isAnonymous
    final displayName = feedback.isAnonymous == 1 ? 'Anonymous' : feedback.userId.split(':').first;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      leading: CircleAvatar(
        backgroundColor: Color(0xFFF1F5F9),
        child: Text(
          displayName.substring(0, 1),
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            displayName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          Row(
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < feedback.rating ? Icons.star : Icons.star_border,
                size: 16,
                color: Colors.amber,
              );
            }),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${feedback.feedbackType} • ${feedback.timestamp.substring(0, 10)}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            feedback.feedbackContent,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF334155),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onTap: () {
        Get.snackbar('Feedback', 'Clicked on $displayName\'s feedback');
      },
    );
  }
}