class Transaction {
  final String amount;
  final String description;
  final String date;

  Transaction({
    required this.amount,
    required this.description,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      description: json['description'],
      date: json['date_added'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'date_added': date,
    };
  }
}
