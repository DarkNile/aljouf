class CustomtabsData {
  String? title;
  String? description;
  String? image;

  CustomtabsData({
    this.title,
    this.description,
    this.image,
  });

  CustomtabsData.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    description = json['description'] as String?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['description'] = description;
    json['image'] = image;
    return json;
  }
}
