// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../controllers/academic_controller.dart';
// import '../models/academic_model.dart';
// import '../widgets/admin_navbar.dart';
// import '../widgets/admin_top_navbar.dart';
//
// class ManageAcademic extends StatelessWidget {
//   const ManageAcademic({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AcademicController>(
//       init: AcademicController(),
//       builder: (controller) => _ManageAcademicView(controller),
//     );
//   }
// }
//
// class _ManageAcademicView extends StatefulWidget {
//   final AcademicController controller;
//   const _ManageAcademicView(this.controller);
//
//   @override
//   State<_ManageAcademicView> createState() => _ManageAcademicViewState();
// }
//
// class _ManageAcademicViewState extends State<_ManageAcademicView> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _venueController = TextEditingController();
//   final _startDateController = TextEditingController();
//   final _endDateController = TextEditingController();
//   final _startTimeController = TextEditingController();
//   final _durationController = TextEditingController();
//   final _titleFocus = FocusNode();
//   final _descriptionFocus = FocusNode();
//   final _subjectFocus = FocusNode();
//   final _venueFocus = FocusNode();
//   final _startDateFocus = FocusNode();
//   final _endDateFocus = FocusNode();
//   final _startTimeFocus = FocusNode();
//   final _durationFocus = FocusNode();
//
//   String _selectedYear = '1st Year';
//   String _selectedSemester = 'First';
//   String _selectedExamType = 'Mid-Term';
//   String _selectedHolidayType = 'Academic Holiday';
//
//   final List<String> _years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
//   final List<String> _semesters = ['First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eighth'];
//   final List<String> _examTypes = ['Mid-Term', 'Final', 'Quiz'];
//   final List<String> _holidayTypes = ['Academic Holiday', 'National Holiday', 'Festival'];
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.controller.fetchEvents();
//     });
//   }
//
//   @override
//   void dispose() {
//     FocusScope.of(context).unfocus();
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _subjectController.dispose();
//     _venueController.dispose();
//     _startDateController.dispose();
//     _endDateController.dispose();
//     _startTimeController.dispose();
//     _durationController.dispose();
//     _titleFocus.dispose();
//     _descriptionFocus.dispose();
//     _subjectFocus.dispose();
//     _venueFocus.dispose();
//     _startDateFocus.dispose();
//     _endDateFocus.dispose();
//     _startTimeFocus.dispose();
//     _durationFocus.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectDate(TextEditingController controller, FocusNode focusNode) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//       builder: (context, child) => Theme(
//         data: ThemeData.light().copyWith(
//           primaryColor: const Color(0xFF042F6B),
//           colorScheme: const ColorScheme.light(primary: Color(0xFF042F6B)),
//           buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
//         ),
//         child: child!,
//       ),
//     );
//     if (picked != null) {
//       controller.text = DateFormat('yyyy-MM-dd').format(picked);
//     }
//     focusNode.requestFocus();
//   }
//
//   Future<void> _selectStartTime() async {
//     final picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       _startTimeController.text = _convertTo24HourFormat(picked);
//     }
//   }
//
//   String _convertTo24HourFormat(TimeOfDay time) {
//     final formatter = DateFormat('HH:mm:ss');
//     final parsedTime = DateTime(0, 0, 0, time.hour, time.minute);
//     return formatter.format(parsedTime);
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       final event = AcademicEvent(
//         title: _titleController.text,
//         description: _descriptionController.text,
//         eventType: widget.controller.selectedEventType.value,
//         examType: widget.controller.selectedEventType.value == 'EXAM' ? _selectedExamType : null,
//         subject: widget.controller.selectedEventType.value == 'EXAM' ? _subjectController.text : null,
//         holidayType: widget.controller.selectedEventType.value == 'HOLIDAY' ? _selectedHolidayType : null,
//         startDate: _startDateController.text,
//         endDate: _endDateController.text,
//         startTime: widget.controller.selectedEventType.value == 'EXAM' ? _startTimeController.text : null,
//         duration: widget.controller.selectedEventType.value == 'EXAM' ? int.tryParse(_durationController.text) : null,
//         venue: widget.controller.selectedEventType.value == 'EXAM' ? _venueController.text : null,
//         year: _selectedYear,
//         semester: _selectedSemester,
//       );
//       widget.controller.createEvent(event);
//       _clearForm();
//     }
//   }
//
//   void _clearForm() {
//     _titleController.clear();
//     _descriptionController.clear();
//     _subjectController.clear();
//     _venueController.clear();
//     _startDateController.clear();
//     _endDateController.clear();
//     _startTimeController.clear();
//     _durationController.clear();
//     _selectedYear = '1st Year';
//     _selectedSemester = 'First';
//     _selectedExamType = 'Mid-Term';
//     _selectedHolidayType = 'Academic Holiday';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
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
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildFormSection(context),
//                   const SizedBox(width: 20),
//                   _buildEventListSection(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFormSection(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.3,
//       padding: const EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: const [
//                 Icon(Icons.event, color: Color(0xFF042F6B), size: 28),
//                 SizedBox(width: 10),
//                 Text(
//                   "Manage Academic Events",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                     color: Color(0xFF042F6B),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 30, thickness: 1),
//             Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ChoiceChip(
//                   label: Text('Exam'),
//                   selected: widget.controller.selectedEventType.value == 'EXAM',
//                   onSelected: (selected) {
//                     if (selected) widget.controller.selectedEventType.value = 'EXAM';
//                   },
//                   selectedColor: Color(0xFF042F6B),
//                   labelStyle: TextStyle(
//                     color: widget.controller.selectedEventType.value == 'EXAM' ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 ChoiceChip(
//                   label: Text('Holiday'),
//                   selected: widget.controller.selectedEventType.value == 'HOLIDAY',
//                   onSelected: (selected) {
//                     if (selected) widget.controller.selectedEventType.value = 'HOLIDAY';
//                   },
//                   selectedColor: Color(0xFF042F6B),
//                   labelStyle: TextStyle(
//                     color: widget.controller.selectedEventType.value == 'HOLIDAY' ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ],
//             )),
//             const SizedBox(height: 10),
//             _buildTextField("Title", _titleController, Icons.title, _titleFocus),
//             _buildDescriptionTextField("Description", _descriptionController, _descriptionFocus),
//             Obx(() => widget.controller.selectedEventType.value == 'EXAM'
//                 ? Column(
//               children: [
//                 _buildDropdownField("Exam Type", _selectedExamType, _examTypes, (value) => setState(() => _selectedExamType = value!)),
//                 _buildTextField("Subject", _subjectController, Icons.book, _subjectFocus),
//                 _buildTextField("Venue", _venueController, Icons.location_on, _venueFocus),
//                 _buildTimeField("Start Time", _startTimeController, _startTimeFocus),
//                 _buildTextField("Duration (minutes)", _durationController, Icons.timer, _durationFocus, isNumber: true),
//               ],
//             )
//                 : SizedBox.shrink()),
//             _buildDropdownField("Year", _selectedYear, _years, (value) => setState(() => _selectedYear = value!)),
//             _buildDropdownField("Semester", _selectedSemester, _semesters, (value) => setState(() => _selectedSemester = value!)),
//             _buildDateField("Start Date", _startDateController, _startDateFocus),
//             _buildDateField("End Date", _endDateController, _endDateFocus),
//             Obx(() => widget.controller.selectedEventType.value == 'EXAM'
//                 ? SizedBox.shrink()
//                 : _buildDropdownField("Holiday Type", _selectedHolidayType, _holidayTypes, (value) => setState(() => _selectedHolidayType = value!))),
//             const SizedBox(height: 20),
//             Center(
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _submitForm,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF042F6B),
//                     padding: const EdgeInsets.symmetric(vertical: 18),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     elevation: 5,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.add_circle, color: Colors.white),
//                       SizedBox(width: 10),
//                       Text(
//                         "Add Event",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEventListSection() {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: const [
//             BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
//           ],
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Obx(() {
//           if (widget.controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator(color: Color(0xFF042F6B)));
//           } else if (widget.controller.errorMessage.isNotEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, color: Colors.red, size: 48),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error: ${widget.controller.errorMessage}',
//                     style: const TextStyle(color: Colors.red, fontSize: 16),
//                   ),
//                 ],
//               ),
//             );
//           } else if (widget.controller.events.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.event_busy, size: 64, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text('No events available', style: TextStyle(fontSize: 18, color: Colors.grey)),
//                   SizedBox(height: 8),
//                   Text('Add a new event to get started', style: TextStyle(fontSize: 14, color: Colors.grey)),
//                 ],
//               ),
//             );
//           }
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: const [
//                       Icon(Icons.list_alt, color: Color(0xFF042F6B), size: 28),
//                       SizedBox(width: 10),
//                       Text(
//                         "Academic Events",
//                         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF042F6B)),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "${widget.controller.events.length} Event${widget.controller.events.length > 1 ? 's' : ''}",
//                     style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//               const Divider(height: 30, thickness: 1),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: widget.controller.events.length,
//                   itemBuilder: (context, index) {
//                     final event = widget.controller.events[index];
//                     return Card(
//                       elevation: 3,
//                       margin: const EdgeInsets.only(bottom: 16),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       child: IntrinsicHeight(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey.shade200, width: 1),
//                           ),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: event.eventType == 'EXAM' ? Colors.red : Colors.green,
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(12),
//                                     bottomLeft: Radius.circular(12),
//                                   ),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "${index + 1}",
//                                       style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
//                                     ),
//                                     Icon(
//                                       event.eventType == 'EXAM' ? Icons.school : Icons.event,
//                                       color: Colors.white,
//                                       size: 22,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         event.title,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                           color: Color(0xFF042F6B),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           const Icon(Icons.description, size: 14, color: Colors.grey),
//                                           const SizedBox(width: 4),
//                                           Expanded(
//                                             child: Text(
//                                               event.description,
//                                               style: const TextStyle(color: Colors.grey, fontSize: 14),
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(event.startDate))}',
//                                             style: const TextStyle(color: Colors.grey, fontSize: 14),
//                                           ),
//                                         ],
//                                       ),
//                                       if (event.eventType == 'EXAM' && event.venue != null)
//                                         Row(
//                                           children: [
//                                             const Icon(Icons.location_on, size: 14, color: Colors.grey),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               'Venue: ${event.venue}',
//                                               style: const TextStyle(color: Colors.grey, fontSize: 14),
//                                             ),
//                                           ],
//                                         ),
//                                       if (event.eventType == 'EXAM' && event.startTime != null)
//                                         Row(
//                                           children: [
//                                             const Icon(Icons.access_time, size: 14, color: Colors.grey),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               'Time: ${event.startTime}',
//                                               style: const TextStyle(color: Colors.grey, fontSize: 14),
//                                             ),
//                                           ],
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.edit, color: Color(0xFF042F6B)),
//                                       onPressed: () {},
//                                       tooltip: "Edit Event",
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.delete, color: Colors.red),
//                                       onPressed: () {},
//                                       tooltip: "Delete Event",
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildTextField(
//       String label,
//       TextEditingController controller,
//       IconData icon,
//       FocusNode focusNode, {
//         bool isNumber = false,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         focusNode: focusNode,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: const Color(0xFF042F6B)),
//           filled: true,
//           fillColor: Colors.grey[50],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
//           ),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) return "Please enter $label";
//           if (isNumber && int.tryParse(value) == null) return "Please enter a valid number";
//           return null;
//         },
//         onFieldSubmitted: (_) => focusNode.unfocus(),
//       ),
//     );
//   }
//
//   Widget _buildDescriptionTextField(String label, TextEditingController controller, FocusNode focusNode) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         focusNode: focusNode,
//         maxLines: 3,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: const Padding(
//             padding: EdgeInsets.only(bottom: 64),
//             child: Icon(Icons.description, color: Color(0xFF042F6B)),
//           ),
//           filled: true,
//           fillColor: Colors.grey[50],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
//           ),
//         ),
//         validator: (value) => value!.isEmpty ? "Please enter $label" : null,
//         onFieldSubmitted: (_) => focusNode.unfocus(),
//       ),
//     );
//   }
//
//   Widget _buildDateField(String label, TextEditingController controller, FocusNode focusNode) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         focusNode: focusNode,
//         readOnly: true,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF042F6B)),
//           filled: true,
//           fillColor: Colors.grey[50],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
//         ),
//       ),
//       onTap: () => _selectDate(controller, focusNode),
//       validator: (value) => value!.isEmpty ? "Please select a date" : null,
//     ),
//     );
//   }
//
//   Widget _buildTimeField(String label, TextEditingController controller, FocusNode focusNode) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         focusNode: focusNode,
//         readOnly: true,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: const Icon(Icons.access_time, color: Color(0xFF042F6B)),
//           filled: true,
//           fillColor: Colors.grey[50],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
//           ),
//         ),
//         onTap: _selectStartTime,
//         validator: (value) => value!.isEmpty ? "Please select a time" : null,
//       ),
//     );
//   }
//
//   Widget _buildDropdownField(String label, String value, List<String> items, void Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: const Icon(Icons.list, color: Color(0xFF042F6B)),
//           filled: true,
//           fillColor: Colors.grey[50],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
//           ),
//         ),
//         items: items.map((item) {
//           return DropdownMenuItem(
//             value: item,
//             child: Text(item),
//           );
//         }).toList(),
//         onChanged: onChanged,
//         validator: (value) => value == null ? "Please select $label" : null,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/academic_controller.dart';
import '../models/academic_model.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';

class ManageAcademic extends StatelessWidget {
  const ManageAcademic({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademicController>(
      init: AcademicController(),
      builder: (controller) => _ManageAcademicView(controller),
    );
  }
}

class _ManageAcademicView extends StatefulWidget {
  final AcademicController controller;
  const _ManageAcademicView(this.controller);

  @override
  State<_ManageAcademicView> createState() => _ManageAcademicViewState();
}

class _ManageAcademicViewState extends State<_ManageAcademicView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  final _venueController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _durationController = TextEditingController();
  final _titleFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _subjectFocus = FocusNode();
  final _venueFocus = FocusNode();
  final _startDateFocus = FocusNode();
  final _endDateFocus = FocusNode();
  final _startTimeFocus = FocusNode();
  final _durationFocus = FocusNode();

  String _selectedYear = '1st Year';
  String _selectedSemester = 'First';
  String _selectedExamType = 'Mid-Term';
  String _selectedHolidayType = 'Academic Holiday';

  final List<String> _years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> _semesters = ['First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eighth'];
  final List<String> _examTypes = ['Mid-Term', 'Final', 'Quiz'];
  final List<String> _holidayTypes = ['Academic Holiday', 'National Holiday', 'Festival'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.fetchEvents();
    });
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    _titleController.dispose();
    _descriptionController.dispose();
    _subjectController.dispose();
    _venueController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _durationController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _subjectFocus.dispose();
    _venueFocus.dispose();
    _startDateFocus.dispose();
    _endDateFocus.dispose();
    _startTimeFocus.dispose();
    _durationFocus.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller, FocusNode focusNode) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF042F6B),
          colorScheme: const ColorScheme.light(primary: Color(0xFF042F6B)),
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
    focusNode.requestFocus();
  }

  Future<void> _selectStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      _startTimeController.text = _convertTo24HourFormat(picked);
    }
  }

  String _convertTo24HourFormat(TimeOfDay time) {
    final formatter = DateFormat('HH:mm:ss');
    final parsedTime = DateTime(0, 0, 0, time.hour, time.minute);
    return formatter.format(parsedTime);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final event = AcademicEvent(
        title: _titleController.text,
        description: _descriptionController.text,
        eventType: widget.controller.selectedEventType.value,
        examType: widget.controller.selectedEventType.value == 'EXAM' ? _selectedExamType : null,
        subject: widget.controller.selectedEventType.value == 'EXAM' ? _subjectController.text : null,
        holidayType: widget.controller.selectedEventType.value == 'HOLIDAY' ? _selectedHolidayType : null,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        startTime: widget.controller.selectedEventType.value == 'EXAM' ? _startTimeController.text : null,
        duration: widget.controller.selectedEventType.value == 'EXAM' ? int.tryParse(_durationController.text) : null,
        venue: widget.controller.selectedEventType.value == 'EXAM' ? _venueController.text : null,
        year: _selectedYear,
        semester: _selectedSemester,
      );
      widget.controller.createEvent(event);
      _clearForm();
    }
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _subjectController.clear();
    _venueController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _startTimeController.clear();
    _durationController.clear();
    _selectedYear = '1st Year';
    _selectedSemester = 'First';
    _selectedExamType = 'Mid-Term';
    _selectedHolidayType = 'Academic Holiday';
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormSection(context),
                  const SizedBox(width: 20),
                  _buildEventListSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.event, color: Color(0xFF042F6B), size: 28),
                  SizedBox(width: 10),
                  Text(
                    "Manage Academic Events",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF042F6B),
                    ),
                  ),
                ],
              ),
              const Divider(height: 30, thickness: 1),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChip(
                    label: Text('Exam'),
                    selected: widget.controller.selectedEventType.value == 'EXAM',
                    onSelected: (selected) {
                      if (selected) widget.controller.selectedEventType.value = 'EXAM';
                    },
                    selectedColor: Color(0xFF042F6B),
                    labelStyle: TextStyle(
                      color: widget.controller.selectedEventType.value == 'EXAM' ? Colors.white : Colors.black,
                    ),
                  ),
                  ChoiceChip(
                    label: Text('Holiday'),
                    selected: widget.controller.selectedEventType.value == 'HOLIDAY',
                    onSelected: (selected) {
                      if (selected) widget.controller.selectedEventType.value = 'HOLIDAY';
                    },
                    selectedColor: Color(0xFF042F6B),
                    labelStyle: TextStyle(
                      color: widget.controller.selectedEventType.value == 'HOLIDAY' ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 10),
              _buildTextField("Title", _titleController, Icons.title, _titleFocus),
              _buildDescriptionTextField("Description", _descriptionController, _descriptionFocus),
              Obx(() => widget.controller.selectedEventType.value == 'EXAM'
                  ? Column(
                children: [
                  _buildDropdownField("Exam Type", _selectedExamType, _examTypes, (value) => setState(() => _selectedExamType = value!)),
                  _buildTextField("Subject", _subjectController, Icons.book, _subjectFocus),
                  _buildTextField("Venue", _venueController, Icons.location_on, _venueFocus),
                  _buildTimeField("Start Time", _startTimeController, _startTimeFocus),
                  _buildTextField("Duration (minutes)", _durationController, Icons.timer, _durationFocus, isNumber: true),
                ],
              )
                  : SizedBox.shrink()),
              _buildDropdownField("Year", _selectedYear, _years, (value) => setState(() => _selectedYear = value!)),
              _buildDropdownField("Semester", _selectedSemester, _semesters, (value) => setState(() => _selectedSemester = value!)),
              _buildDateField("Start Date", _startDateController, _startDateFocus),
              _buildDateField("End Date", _endDateController, _endDateFocus),
              Obx(() => widget.controller.selectedEventType.value == 'EXAM'
                  ? SizedBox.shrink()
                  : _buildDropdownField("Holiday Type", _selectedHolidayType, _holidayTypes, (value) => setState(() => _selectedHolidayType = value!))),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF042F6B),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_circle, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Add Event",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventListSection() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          if (widget.controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF042F6B)));
          } else if (widget.controller.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${widget.controller.errorMessage}',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (widget.controller.events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.event_busy, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No events available', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 8),
                  Text('Add a new event to get started', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.list_alt, color: Color(0xFF042F6B), size: 28),
                      SizedBox(width: 10),
                      Text(
                        "Academic Events",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF042F6B)),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.controller.events.length} Event${widget.controller.events.length > 1 ? 's' : ''}",
                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Divider(height: 30, thickness: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.controller.events.length,
                  itemBuilder: (context, index) {
                    final event = widget.controller.events[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200, width: 1),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: event.eventType == 'EXAM' ? Colors.red : Colors.green,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${index + 1}",
                                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      event.eventType == 'EXAM' ? Icons.school : Icons.event,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF042F6B),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.description, size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              event.description,
                                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(event.startDate))}',
                                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      if (event.eventType == 'EXAM' && event.venue != null)
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Venue: ${event.venue}',
                                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      if (event.eventType == 'EXAM' && event.startTime != null)
                                        Row(
                                          children: [
                                            const Icon(Icons.access_time, size: 14, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Time: ${event.startTime}',
                                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Color(0xFF042F6B)),
                                      onPressed: () {},
                                      tooltip: "Edit Event",
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {},
                                      tooltip: "Delete Event",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      IconData icon,
      FocusNode focusNode, {
        bool isNumber = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF042F6B)),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Please enter $label";
          if (isNumber && int.tryParse(value) == null) return "Please enter a valid number";
          return null;
        },
        onFieldSubmitted: (_) => focusNode.unfocus(),
      ),
    );
  }

  Widget _buildDescriptionTextField(String label, TextEditingController controller, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(bottom: 64),
            child: Icon(Icons.description, color: Color(0xFF042F6B)),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        validator: (value) => value!.isEmpty ? "Please enter $label" : null,
        onFieldSubmitted: (_) => focusNode.unfocus(),
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF042F6B)),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        onTap: () => _selectDate(controller, focusNode),
        validator: (value) => value!.isEmpty ? "Please select a date" : null,
      ),
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.access_time, color: Color(0xFF042F6B)),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        onTap: _selectStartTime,
        validator: (value) => value!.isEmpty ? "Please select a time" : null,
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> items, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.list, color: Color(0xFF042F6B)),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? "Please select $label" : null,
      ),
    );
  }
}