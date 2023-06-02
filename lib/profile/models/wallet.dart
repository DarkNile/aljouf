import 'package:aljouf/profile/models/transaction.dart';

class Wallet {
  final String? balance;
  final List<Transaction>? transactions;

  Wallet({
    this.balance,
    this.transactions,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: json['user_balance'],
      transactions: json['transactions'] == null
          ? null
          : (json['transactions'] as List)
              .map((e) => Transaction.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_balance': balance,
      'transactions': transactions == null
          ? null
          : transactions!.map((e) => e.toJson()).toList(),
    };
  }
}
