class Popup {
  final bool? showPopup;
  final String? imageUrl;
  final String? width;
  final String? height;

  Popup({
    this.showPopup,
    this.imageUrl,
    this.width,
    this.height,
  });

  factory Popup.fromJson(Map<String, dynamic> json) {
    return Popup(
      showPopup: json['show_popup'],
      imageUrl: json['image_url'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'show_popup': showPopup,
      'image_url': imageUrl,
      'width': width,
      'height': height,
    };
  }
}
