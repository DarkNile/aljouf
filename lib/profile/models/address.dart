class Address {
  final String id;
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String zoneId;
  final String zone;
  final String countryId;
  final String country;

  Address({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.zoneId,
    required this.zone,
    required this.countryId,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['address_id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      address: json['address_1'],
      city: json['city'],
      zoneId: json['zone_id'],
      zone: json['zone'],
      countryId: json['country_id'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_id': id,
      'firstname': firstName,
      'lastname': lastName,
      'address_1': address,
      'city': city,
      'zone_id': zoneId,
      'zone': zone,
      'country_id': countryId,
      'country': country,
    };
  }
}
