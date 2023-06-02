class Location {
  String? locationId;
  String? name;
  String? address;
  String? geocode;
  String? image;
  String? telephone;

  Location({
    this.locationId,
    this.name,
    this.address,
    this.geocode,
    this.image,
    this.telephone,
  });

  Location.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    name = json['name'];
    address = json['address'];
    geocode = json['geocode'];
    image = json['image'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['location_id'] = locationId;
    json['name'] = name;
    json['address'] = address;
    json['geocode'] = geocode;
    json['image'] = image;
    json['telephone'] = telephone;
    return json;
  }
}
