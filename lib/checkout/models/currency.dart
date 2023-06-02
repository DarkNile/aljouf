class Currency {
  String? currencyId;
  String? symbolLeft;
  String? symbolRight;
  String? decimalPlace;
  String? value;

  Currency(
      {this.currencyId,
      this.symbolLeft,
      this.symbolRight,
      this.decimalPlace,
      this.value});

  Currency.fromJson(Map<String, dynamic> json) {
    currencyId = json["currency_id"];
    symbolLeft = json["symbol_left"];
    symbolRight = json["symbol_right"];
    decimalPlace = json["decimal_place"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["currency_id"] = currencyId;
    data["symbol_left"] = symbolLeft;
    data["symbol_right"] = symbolRight;
    data["decimal_place"] = decimalPlace;
    data["value"] = value;
    return data;
  }
}
