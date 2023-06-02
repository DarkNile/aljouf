import 'package:aljouf/product/models/review.dart';

class Reviews {
  String? reviewTotal;
  List<Review>? reviews;

  Reviews({this.reviewTotal, this.reviews});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewTotal = json["review_total"];
    reviews = json["reviews"] == null
        ? null
        : (json["reviews"] as List).map((e) => Review.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["review_total"] = reviewTotal;
    if (reviews != null) {
      data["reviews"] = reviews?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
