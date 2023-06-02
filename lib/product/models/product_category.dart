class ProductCategory {
  String? name;
  int? id;

  ProductCategory({this.name, this.id});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    return data;
  }
}
