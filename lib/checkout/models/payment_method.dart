class PaymentMethod {
  String code;
  String title;

  PaymentMethod({
    required this.code,
    required this.title,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      code: json['code'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
    };
  }
}
