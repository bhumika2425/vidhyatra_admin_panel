// class Fee {
//   final String id; // Optional, if your backend assigns IDs
//   final String feeType;
//   final String feeDescription;
//   final double feeAmount;
//   final String dueDate;
//   final String createdAt;
//   final String updatedAt;
//
//   Fee({
//     this.id = '',
//     required this.feeType,
//     required this.feeDescription,
//     required this.feeAmount,
//     required this.dueDate,
//     required this.createdAt,
//     required this.updatedAt,
//   });
// }
//
// class PaidFee {
//   final String studentName;
//   final String studentId;
//   final String feeType;
//   final double amountPaid;
//   final String paymentDate;
//
//   PaidFee({
//     required this.studentName,
//     required this.studentId,
//     required this.feeType,
//     required this.amountPaid,
//     required this.paymentDate,
//   });
// }

// Dummy model for fees
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
}

// Dummy model for fee payments
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
}