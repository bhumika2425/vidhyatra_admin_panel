import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/fees_controller.dart';
import '../models/fees_model.dart';
import '../widgets/admin_navbar.dart';
import '../widgets/admin_top_navbar.dart';

class FeesPage extends StatelessWidget {
  final FeeController controller = Get.put(FeeController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feeTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  FeesPage({super.key});

  // Function to open date picker and set the date in the controller
  Future<void> _selectDueDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF042F6B),
            colorScheme: ColorScheme.light(primary: Color(0xFF042F6B)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _dueDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create a new fee
      final newFee = Fee(
        id: (controller.fees.length + 1).toString(),
        feeType: _feeTypeController.text,
        description: _descriptionController.text,
        amount: double.parse(_amountController.text),
        dueDate: _dueDateController.text,
        createdAt: DateTime.now().toIso8601String(),
      );

      // Add the fee
      controller.addFee(newFee);

      // Clear form fields
      _feeTypeController.clear();
      _descriptionController.clear();
      _amountController.clear();
      _dueDateController.clear();

      // Show success message
      Get.snackbar(
        'Success',
        'Fee added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AdminTopNavBar(),
      ),
      body: Row(
        children: [
          AdminNavBar(onTap: (index) {
            // Handle sidebar navigation if needed
          }),
          Expanded(
            child: Container(
              color: Colors.grey[200], // Grey 200 background color
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fee Form Section (30% of the screen width)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.payments, color: Color(0xFF042F6B), size: 28),
                              SizedBox(width: 10),
                              Text(
                                "Manage Fees",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Color(0xFF042F6B),
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 30, thickness: 1),
                          _buildTextField(
                            "Fee Type",
                            _feeTypeController,
                            Icons.category,
                            context,
                          ),
                          _buildDescriptionTextField(
                            "Fee Description",
                            _descriptionController,
                            context,
                          ),
                          _buildTextField(
                            "Amount",
                            _amountController,
                            Icons.attach_money,
                            context,
                            isNumber: true,
                          ),
                          _buildDateField(
                            "Due Date",
                            _dueDateController,
                            context,
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF042F6B),
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_circle, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      "Add New Fee",
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
                  SizedBox(width: 20),
                  // Fee Payments List Section
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Obx(() {
                        // Checking if the data is still loading
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF042F6B),
                            ),
                          );
                        } else if (controller.errorMessage.isNotEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline, color: Colors.red, size: 48),
                                SizedBox(height: 16),
                                Text(
                                  'Error: ${controller.errorMessage}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (controller.feePayments.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.payments_outlined,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No fee payments available',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Students will appear here after paying fees',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Display fee payments in a ListView
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.list_alt, color: Color(0xFF042F6B), size: 28),
                                      SizedBox(width: 10),
                                      Text(
                                        "Fee Payments",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF042F6B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${controller.feePayments.length} Payment${controller.feePayments.length > 1 ? 's' : ''}",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(height: 30, thickness: 1),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.feePayments.length,
                                  itemBuilder: (context, index) {
                                    var payment = controller.feePayments[index];
                                    return Card(
                                      elevation: 3,
                                      margin: EdgeInsets.only(bottom: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF042F6B),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(12),
                                                    bottomLeft: Radius.circular(12),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${index + 1}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: 22,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${payment.studentName}",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Color(0xFF042F6B),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.badge, size: 14, color: Colors.grey[600]),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            "ID: ${payment.studentId}",
                                                            style: TextStyle(
                                                              color: Colors.grey[700],
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 4),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.category, size: 14, color: Colors.grey[600]),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            "Fee: ${payment.feeType}",
                                                            style: TextStyle(
                                                              color: Colors.grey[700],
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 4),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.attach_money, size: 14, color: Colors.grey[600]),
                                                                SizedBox(width: 4),
                                                                Text(
                                                                  "Amount: ₹${payment.amount.toStringAsFixed(2)}",
                                                                  style: TextStyle(
                                                                    color: Colors.grey[700],
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 16),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                                                                SizedBox(width: 4),
                                                                Text(
                                                                  "Paid: ${payment.paymentDate}",
                                                                  style: TextStyle(
                                                                    color: Colors.grey[700],
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.receipt_long,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        // View receipt action
                                                      },
                                                      tooltip: "View Receipt",
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.print,
                                                        color: Colors.blue,
                                                      ),
                                                      onPressed: () {
                                                        // Print receipt action
                                                      },
                                                      tooltip: "Print Receipt",
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
                        }
                      }),
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

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      IconData icon,
      BuildContext context, {
        bool isNumber = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF042F6B)),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          if (isNumber) {
            if (double.tryParse(value) == null) {
              return "Please enter a valid number";
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(
      String label,
      TextEditingController controller,
      BuildContext context,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(bottom: 64),
            child: Icon(Icons.description, color: Color(0xFF042F6B)),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField(
      String label,
      TextEditingController controller,
      BuildContext context,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF042F6B)),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF042F6B), width: 2),
          ),
        ),
        onTap: () => _selectDueDate(context),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select a date";
          }
          return null;
        },
      ),
    );
  }
}