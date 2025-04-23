class Fee {
  final String id;
  final String feeType;
  final String description;
  final double amount;
  final String dueDate;
  final String createdAt;

  Fee({
    required this.id,
    required this.feeType,
    required this.description,
    required this.amount,
    required this.dueDate,
    required this.createdAt,
  });

  // Factory method to create a Fee from JSON
  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      id: json['id']?.toString() ?? '',
      feeType: json['feeType'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount'] is int ? json['amount'].toDouble() : json['amount']) ?? 0.0,
      dueDate: json['dueDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  // Method to convert Fee to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feeType': feeType,
      'description': description,
      'amount': amount,
      'dueDate': dueDate,
      'createdAt': createdAt,
    };
  }
}

// Model for fee payments
class FeePayment {
  final String id;
  final String studentName;
  final String studentId;
  final String feeType;
  final double amount;
  final String paymentDate;
  final String receiptNumber;

  FeePayment({
    required this.id,
    required this.studentName,
    required this.studentId,
    required this.feeType,
    required this.amount,
    required this.paymentDate,
    required this.receiptNumber,
  });

  // Factory method to create a FeePayment from JSON
  factory FeePayment.fromJson(Map<String, dynamic> json) {
    return FeePayment(
      id: json['id']?.toString() ?? '',
      studentName: json['studentName'] ?? '',
      studentId: json['studentId'] ?? '',
      feeType: json['feeType'] ?? '',
      amount: (json['amount'] is int ? json['amount'].toDouble() : json['amount']) ?? 0.0,
      paymentDate: json['paymentDate'] ?? '',
      receiptNumber: json['receiptNumber'] ?? '',
    );
  }

  // Method to convert FeePayment to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentName': studentName,
      'studentId': studentId,
      'feeType': feeType,
      'amount': amount,
      'paymentDate': paymentDate,
      'receiptNumber': receiptNumber,
    };
  }
}