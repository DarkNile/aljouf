class Quote {
  String code;
  String title;
  int cost;
  dynamic taxClassId;
  String text;

  Quote({
    required this.code,
    required this.title,
    required this.cost,
    required this.taxClassId,
    required this.text,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      code: json['code'],
      title: json['title'],
      cost: json['cost'],
      taxClassId: json['tax_class_id'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'cost': cost,
      'tax_class_id': taxClassId,
      'text': text,
    };
  }
}
