class Total {
  String? title;
  String? text;
  dynamic value;

  Total({this.title, this.text, this.value});

  Total.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    text = json["text"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["text"] = text;
    data["value"] = value;
    return data;
  }
}
