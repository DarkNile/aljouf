import 'package:aljouf/product/models/custom_tabs.dart';
import 'package:aljouf/product/models/options.dart';
import 'package:aljouf/product/models/product_category.dart';
import 'package:aljouf/product/models/reviews.dart';
import 'package:aljouf/product/models/size_option.dart';

class Product {
  dynamic id;
  dynamic productId;
  String? name;
  String? url;
  String? manufacturer;
  String? sku;
  dynamic priceRaw;
  dynamic totalRaw;
  bool? fav;
  String? model;
  String? image;
  List<String>? images;
  String? originalImage;
  List<String>? originalImages;
  dynamic priceExcludingTax;
  String? priceExcludingTaxFormated;
  dynamic price;
  dynamic originPrice;
  String? priceFormated;
  int? rating;
  String? description;
  List<dynamic>? attributeGroups;
  dynamic special;
  dynamic specialExcludingTax;
  String? specialExcludingTaxFormated;
  String? specialFormated;
  String? specialStartDate;
  String? specialEndDate;
  List<dynamic>? discounts;
  List<Options>? options;
  String? minimum;
  String? metaTitle;
  String? metaDescription;
  String? metaKeyword;
  String? seoUrl;
  String? tag;
  String? upc;
  String? ean;
  String? jan;
  String? isbn;
  String? mpn;
  String? location;
  String? stockStatus;
  dynamic stockStatusId;
  int? manufacturerId;
  int? taxClassId;
  String? dateAvailable;
  dynamic weight;
  int? weightClassId;
  String? length;
  String? width;
  String? height;
  int? lengthClassId;
  String? subtract;
  String? sortOrder;
  String? status;
  String? dateAdded;
  String? dateModified;
  String? viewed;
  String? weightClass;
  String? lengthClass;
  String? shipping;
  dynamic reward;
  dynamic points;
  List<ProductCategory>? category;
  // --- I Add Stock To Check Products On Cart ---
  bool? stock;
  dynamic quantity;
  dynamic qty;
  Reviews? reviews;
  Customtabs? customTabs;
  List<dynamic>? recurrings;
  List<SizeOption>? option;

  Product({
    this.id,
    this.productId,
    this.name,
    this.customTabs,
    this.url,
    this.manufacturer,
    this.originPrice,
    this.qty,
    this.fav,
    this.sku,
    this.priceRaw,
    this.totalRaw,
    this.model,
    this.image,
    this.images,
    this.originalImage,
    this.originalImages,
    this.priceExcludingTax,
    this.priceExcludingTaxFormated,
    this.price,
    this.priceFormated,
    this.rating,
    this.description,
    this.attributeGroups,
    this.special,
    this.specialExcludingTax,
    this.specialExcludingTaxFormated,
    this.specialFormated,
    this.specialStartDate,
    this.specialEndDate,
    this.discounts,
    this.options,
    this.minimum,
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
    this.seoUrl,
    this.tag,
    this.upc,
    this.ean,
    this.jan,
    this.isbn,
    this.mpn,
    this.location,
    this.stockStatus,
    this.stockStatusId,
    this.manufacturerId,
    this.taxClassId,
    this.dateAvailable,
    this.weight,
    this.weightClassId,
    this.length,
    this.width,
    this.height,
    this.lengthClassId,
    this.subtract,
    this.sortOrder,
    this.status,
    this.dateAdded,
    this.dateModified,
    this.viewed,
    this.weightClass,
    this.lengthClass,
    this.shipping,
    this.reward,
    this.points,
    this.category,
    this.stock,
    this.quantity,
    this.reviews,
    this.recurrings,
    this.option,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? json['key'] ?? json['product_id'];
    productId = json["product_id"];
    name = json["name"];
    fav = false;
    manufacturer = json["manufacturer"];
    sku = json["sku"];
    model = json["model"];
    // --- Form Json Only To Read ---
    stock = json["stock"];
    // ---
    url = json["url"];
    image = json["image"];
    images = json["images"] == null ? null : List<String>.from(json["images"]);
    originalImage = json["original_image"];
    originalImages = (json["original_images"] == null
        ? null
        : List<String>.from(json["original_images"]));
    priceExcludingTax = json["price_excluding_tax"];
    priceExcludingTaxFormated = json["price_excluding_tax_formated"];
    price = json["price"];
    originPrice = json["origin_price"];
    priceRaw = json["price_raw"];
    totalRaw = json["total_raw"];
    priceFormated = json["price_formated"];
    rating = json["rating"];
    description = json["description"];
    attributeGroups = json["attribute_groups"] ?? [];
    special = json["special"];
    specialExcludingTax = json["special_excluding_tax"];
    specialExcludingTaxFormated = json["special_excluding_tax_formated"];
    specialFormated = json["special_formated"];
    specialStartDate = json["special_start_date"];
    specialEndDate = json["special_end_date"];
    discounts = json["discounts"] ?? [];
    options = json['options'] == null
        ? null
        : (json['options'] as List).map((e) => Options.fromJson(e)).toList();
    minimum = json["minimum"];
    metaTitle = json["meta_title"];
    metaDescription = json["meta_description"];
    metaKeyword = json["meta_keyword"];
    seoUrl = json["seo_url"];
    tag = json["tag"];
    upc = json["upc"];
    ean = json["ean"];
    jan = json["jan"];
    isbn = json["isbn"];
    mpn = json["mpn"];
    location = json["location"];
    stockStatus = json["stock_status"];
    stockStatusId = json["stock_status_id"];
    manufacturerId = json["manufacturer_id"];
    taxClassId = json["tax_class_id"];
    dateAvailable = json["date_available"];
    weight = json["weight"];
    weightClassId = json["weight_class_id"];
    length = json["length"];
    width = json["width"];
    height = json["height"];
    lengthClassId = json["length_class_id"];
    subtract = json["subtract"];
    sortOrder = json["sort_order"];
    status = json["status"];
    dateAdded = json["date_added"];
    dateModified = json["date_modified"];
    viewed = json["viewed"];
    weightClass = json["weight_class"];
    lengthClass = json["length_class"];
    shipping = json["shipping"];
    reward = json["reward"];
    points = json["points"];
    category = json["category"] == null
        ? null
        : (json["category"] as List)
            .map((e) => ProductCategory.fromJson(e))
            .toList();
    quantity = json["quantity"];
    qty = json["qty"];
    reviews =
        json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]);
    customTabs = (json['customtabs'] as Map<String, dynamic>?) != null
        ? Customtabs.fromJson(json['customtabs'] as Map<String, dynamic>)
        : null;
    recurrings = json["recurrings"] ?? [];
    option = json["option"] == null
        ? null
        : (json["option"] as List).map((e) => SizeOption.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["product_id"] = productId;
    data["name"] = name;
    data["manufacturer"] = manufacturer;
    data["sku"] = sku;
    data["model"] = model;
    data["url"] = url;
    data["image"] = image;
    if (images != null) {
      data["images"] = images;
    }
    data["original_image"] = originalImage;
    if (originalImages != null) {
      data["original_images"] = originalImages;
    }
    data["price_excluding_tax"] = priceExcludingTax;
    data["price_excluding_tax_formated"] = priceExcludingTaxFormated;
    data["price"] = price;
    data["origin_price"] = originPrice;
    data["price_formated"] = priceFormated;
    data["rating"] = rating;
    data["description"] = description;
    if (attributeGroups != null) {
      data["attribute_groups"] = attributeGroups;
    }
    data["special"] = special;
    data["special_excluding_tax"] = specialExcludingTax;
    data["special_excluding_tax_formated"] = specialExcludingTaxFormated;
    data["special_formated"] = specialFormated;
    data["special_start_date"] = specialStartDate;
    data["special_end_date"] = specialEndDate;
    if (discounts != null) {
      data["discounts"] = discounts;
    }
    if (options != null) {
      data['options'] = options?.map((e) => e.toJson()).toList();
    }
    data["minimum"] = minimum;
    data["meta_title"] = metaTitle;
    data["meta_description"] = metaDescription;
    data["meta_keyword"] = metaKeyword;
    data["seo_url"] = seoUrl;
    data["tag"] = tag;
    data["upc"] = upc;
    data["ean"] = ean;
    data["jan"] = jan;
    data["isbn"] = isbn;
    data["mpn"] = mpn;
    data["location"] = location;
    data["stock_status"] = stockStatus;
    data["stock_status_id"] = stockStatusId;
    data["manufacturer_id"] = manufacturerId;
    data["tax_class_id"] = taxClassId;
    data["date_available"] = dateAvailable;
    data["weight"] = weight;
    data["weight_class_id"] = weightClassId;
    data["length"] = length;
    data["width"] = width;
    data["height"] = height;
    data["length_class_id"] = lengthClassId;
    data["subtract"] = subtract;
    data["sort_order"] = sortOrder;
    data["status"] = status;
    data["date_added"] = dateAdded;
    data["date_modified"] = dateModified;
    data["viewed"] = viewed;
    data["weight_class"] = weightClass;
    data["length_class"] = lengthClass;
    data["shipping"] = shipping;
    data["reward"] = reward;
    data["points"] = points;
    if (category != null) {
      data["category"] = category?.map((e) => e.toJson()).toList();
    }
    data["quantity"] = quantity;
    data["qty"] = qty;
    if (reviews != null) {
      data["reviews"] = reviews?.toJson();
    }
    if (customTabs != null) {
      data["customtabs"] = customTabs?.toJson();
    }

    if (recurrings != null) {
      data["recurrings"] = recurrings;
    }
    if (option != null) {
      data["option"] = option?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
