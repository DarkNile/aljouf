import 'package:aljouf/checkout/models/total.dart';
import 'package:aljouf/product/models/product.dart';

class Order {
  int? orderId;
  dynamic total;
  List<Total>? totals;
  String? customerId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingAddress;
  String? shippingCity;
  String? shippingZone;
  String? shippingCountry;
  String? shippingCode;
  String? paymentCode;
  List<dynamic>? vouchers;
  List<Product>? products;

  Order({
    this.orderId,
    this.total,
    this.totals,
    this.customerId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.shippingFirstName,
    this.shippingLastName,
    this.shippingAddress,
    this.shippingCity,
    this.shippingZone,
    this.shippingCountry,
    this.shippingCode,
    this.paymentCode,
    this.vouchers,
    this.products,
  });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    total = json['total'];
    totals = json["totals"] == null
        ? null
        : (json["totals"] as List).map((e) => Total.fromJson(e)).toList();
    customerId = json['customer_id'];
    firstName = json['firstname'];
    lastName = json['lastname'];
    email = json['email'];
    phone = json['telephone'];
    shippingFirstName = json['shipping_firstname'];
    shippingLastName = json['shipping_lastname'];
    shippingAddress = json['shipping_address_1'];
    shippingCity = json['shipping_city'];
    shippingZone = json['shipping_zone'];
    shippingCountry = json['shipping_country'];
    shippingCode = json['shipping_code'];
    paymentCode = json['payment_code'];
    vouchers = json['vouchers'];
    products = json["products"] == null
        ? null
        : (json["products"] as List).map((e) => Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['total'] = total;
    if (totals != null) {
      data["totals"] = totals?.map((e) => e.toJson()).toList();
    }
    data['customer_id'] = customerId;
    data['firstname'] = firstName;
    data['lastname'] = lastName;
    data['email'] = email;
    data['telephone'] = phone;
    data['shipping_firstname'] = shippingFirstName;
    data['shipping_lastname'] = shippingLastName;
    data['shipping_address_1'] = shippingAddress;
    data['shipping_city'] = shippingCity;
    data['shipping_zone'] = shippingZone;
    data['shipping_country'] = shippingCountry;
    data['shipping_code'] = shippingCode;
    data['payment_code'] = paymentCode;
    data['vouchers'] = vouchers;
    if (products != null) {
      data["products"] = products?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
