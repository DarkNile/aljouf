class City {
  final String cityId;
  final String zoneId;
  final String countryId;
  final String name;
  final String nameAr;

  City({
    required this.cityId,
    required this.zoneId,
    required this.countryId,
    required this.name,
    required this.nameAr,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['city_id'],
      zoneId: json['zone_id'],
      countryId: json['country_id'],
      name: json['name'],
      nameAr: json['name_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': cityId,
      'zone_id': zoneId,
      'country_id': countryId,
      'name': name,
      'name_ar': nameAr,
    };
  }
}
