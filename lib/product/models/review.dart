class Review {
  String? author;
  String? text;
  dynamic rating;
  String? dateAdded;

  Review({this.author, this.text, this.rating, this.dateAdded});

  Review.fromJson(Map<String, dynamic> json) {
    author = json["author"];
    text = json["text"];
    rating = json["rating"];
    dateAdded = json["date_added"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["author"] = author;
    data["text"] = text;
    data["rating"] = rating;
    data["date_added"] = dateAdded;
    return data;
  }
}
