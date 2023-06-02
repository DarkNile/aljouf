import 'package:aljouf/checkout/models/currency.dart';
import 'package:aljouf/product/models/product.dart';

class TrackingOrder {
  String? orderId;
  String? name;
  String? status;
  String? dateAdded;
  int? productTotal;
  List<Product>? products;
  String? total;
  String? currencyCode;
  String? currencyValue;
  String? totalRaw;
  int? timestamp;
  Currency? currency;

  TrackingOrder({
    this.orderId,
    this.name,
    this.status,
    this.dateAdded,
    this.productTotal,
    this.products,
    this.total,
    this.currencyCode,
    this.currencyValue,
    this.totalRaw,
    this.timestamp,
    this.currency,
  });

  TrackingOrder.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] as String?;
    name = json['name'] as String?;
    status = json['status'] as String?;
    dateAdded = json['date_added'] as String?;
    productTotal = json['product_total'] as int?;
    products = (json['products'] as List?)
        ?.map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    total = json['total'] as String?;
    currencyCode = json['currency_code'] as String?;
    currencyValue = json['currency_value'] as String?;
    totalRaw = json['total_raw'] as String?;
    timestamp = json['timestamp'] as int?;
    currency = (json['currency'] as Map<String, dynamic>?) != null
        ? Currency.fromJson(json['currency'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['order_id'] = orderId;
    json['name'] = name;
    json['status'] = status;
    json['date_added'] = dateAdded;
    json['product_total'] = productTotal;
    json['products'] = products?.map((e) => e.toJson()).toList();
    json['total'] = total;
    json['currency_code'] = currencyCode;
    json['currency_value'] = currencyValue;
    json['total_raw'] = totalRaw;
    json['timestamp'] = timestamp;
    json['currency'] = currency?.toJson();
    return json;
  }
}
