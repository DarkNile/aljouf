class Zone {
  final String zoneId;
  final String countryId;
  final String name;
  final String nameAr;

  Zone({
    required this.zoneId,
    required this.countryId,
    required this.name,
    required this.nameAr,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      zoneId: json['zone_id'],
      countryId: json['country_id'],
      name: json['name'],
      nameAr: json['name_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zone_id': zoneId,
      'country_id': countryId,
      'name': name,
      'name_ar': nameAr,
    };
  }
}
