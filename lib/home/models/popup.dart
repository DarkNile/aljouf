class Popup {
  final bool? showPopup;
  final String? imageUrl;

  Popup({
    this.showPopup,
    this.imageUrl,
  });

  factory Popup.fromJson(Map<String, dynamic> json) {
    return Popup(
      showPopup: json['show_popup'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'show_popup': showPopup,
      'image_url': imageUrl,
    };
  }
}
