class Country {
  final int id;
  final String name;
  final String nameAr;

  Country({
    required this.id,
    required this.name,
    required this.nameAr,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['country_id'],
      name: json['name'],
      nameAr: json['name_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_id': id,
      'name': name,
      'name_ar': nameAr,
    };
  }
}
