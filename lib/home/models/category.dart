class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['category_id'],
      name: json['name'],
      imageUrl: json['mobile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': id,
      'name': name,
      'mobile_image': imageUrl,
    };
  }
}
