class SizeOption {
  final String name;
  final String value;

  SizeOption({
    required this.name,
    required this.value,
  });

  factory SizeOption.fromJson(Map<String, dynamic> json) {
    return SizeOption(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}
