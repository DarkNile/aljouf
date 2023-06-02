import 'package:aljouf/product/models/option.dart';

class Options {
  final int productOptionId;
  final List<Option>? option;

  Options({
    required this.productOptionId,
    this.option,
  });

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      productOptionId: json['product_option_id'],
      option: json['option_value'] == null
          ? null
          : (json['option_value'] as List)
              .map((e) => Option.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_option_id'] = productOptionId;
    if (option != null) {
      data['option_value'] = option?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
