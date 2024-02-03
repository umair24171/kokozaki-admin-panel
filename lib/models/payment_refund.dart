class PaymentRefund {
  double transferAmount;
  String fullName;
  String bankAccountNumber;
  String userId;
  String bankName;
  DateTime reqDate;
  String reqId;
  bool isTransferd;

  PaymentRefund({
    required this.transferAmount,
    required this.fullName,
    required this.bankAccountNumber,
    required this.userId,
    required this.bankName,
    required this.reqDate,
    required this.reqId,
    required this.isTransferd,
  });

  factory PaymentRefund.fromMap(Map<String, dynamic> map) {
    return PaymentRefund(
      transferAmount: map['transferAmount'],
      fullName: map['fullName'],
      bankAccountNumber: map['bankAccountNumber'],
      userId: map['userId'],
      bankName: map['bankName'],
      reqDate: map['reqDate'].toDate(),
      reqId: map['reqId'],
      isTransferd: map['isTransferd'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transferAmount': transferAmount,
      'fullName': fullName,
      'bankAccountNumber': bankAccountNumber,
      'userId': userId,
      'bankName': bankName,
      'reqDate': reqDate,
      'reqId': reqId,
      'isTransferd': isTransferd,
    };
  }
}
