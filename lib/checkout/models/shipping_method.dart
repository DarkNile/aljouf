import 'package:aljouf/checkout/models/quote.dart';

class ShippingMethod {
  String title;
  List<Quote> quote;

  ShippingMethod({
    required this.title,
    required this.quote,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      title: json['title'],
      quote: (json['quote'] as List).map((e) => Quote.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'quote': quote.map((e) => e.toJson()).toList(),
    };
  }
}
