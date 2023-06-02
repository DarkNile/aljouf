import 'package:aljouf/product/models/custom_tabs_data.dart';

class Customtabs {
  List<CustomtabsData>? customtabs;

  Customtabs({
    this.customtabs,
  });

  Customtabs.fromJson(Map<String, dynamic> json) {
    customtabs = (json['customtabs'] as List?)
        ?.map((dynamic e) => CustomtabsData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['customtabs'] = customtabs?.map((e) => e.toJson()).toList();
    return json;
  }
}
