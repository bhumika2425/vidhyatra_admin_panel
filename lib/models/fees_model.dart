class Fee {
  final int feeID;
  final String feeType;
  final String feeDescription;
  final double feeAmount;
  final DateTime dueDate;
  final int adminId;

  Fee({
    required this.feeID,
    required this.feeType,
    required this.feeDescription,
    required this.feeAmount,
    required this.dueDate,
    required this.adminId,
  });

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      feeID: json['feeID'] ?? 0,
      feeType: json['feeType'] ?? '',
      feeDescription: json['feeDescription'] ?? '',
      feeAmount: (json['feeAmount'] ?? 0).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] ?? DateTime.now().toIso8601String()),
      adminId: json['admin_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feeID': feeID,
      'feeType': feeType,
      'feeDescription': feeDescription,
      'feeAmount': feeAmount,
      'dueDate': dueDate.toIso8601String(),
      'admin_id': adminId,
    };
  }
}