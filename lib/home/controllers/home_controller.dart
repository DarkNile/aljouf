import 'package:aljouf/product/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:aljouf/home/models/category.dart';
import 'package:aljouf/home/models/location.dart';
import 'package:aljouf/home/services/home_service.dart';
import 'package:aljouf/product/models/product.dart';

class HomeController extends GetxController {
  var isBannersLoading = false.obs;
  var banners = [].obs; //9
  var honeyBanner = [].obs; //10
  var oliveOilBanner = [].obs; //11
  var oliveBanner = [].obs; //12
  var isCategoriesLoading = false.obs;
  var isSubCategoriesLoading = false.obs;
  var categories = <Category>[].obs;
  var subCategories = <Category>[].obs;
  var isCategoryProductsLoading = false.obs;
  var organicOliveOil = <Product>[].obs; //107
  var honey = <Product>[].obs; //109
  var olive = <Product>[].obs; //166
  var offers = <Product>[].obs; //221
  var jofoliaOliveOil = <Product>[].obs; //225
  var goldenOlive = <Product>[].obs; //226
  var isWishListProductsLoading = false.obs;
  var wishlistProducts = <Product>[].obs;
  var isContactUsLoading = false.obs;
  var isStaticPageLoading = false.obs;
  var staticPageData = <String, dynamic>{}.obs;
  var isLocationsLoading = false.obs;
  var locations = <Location>[].obs;
  //
  var isCreatingCouponLoading = false.obs;
  var isCouponLoading = false.obs;
  var coupon = ''.obs;

  Future<List<dynamic>?> getBanners({required String id}) async {
    try {
      isBannersLoading(true);
      final data = await HomeService.getBanners(id: id);
      if (data != null) {
        if (id == '9') {
          banners(data);
          return banners;
        } else if (id == '10') {
          honeyBanner(data);
          return honeyBanner;
        } else if (id == '11') {
          oliveOilBanner(data);
          return oliveOilBanner;
        } else if (id == '12') {
          oliveBanner(data);
          return oliveBanner;
        }
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isBannersLoading(false);
    }
  }

  Future<List<Category>?> getCategories() async {
    try {
      isCategoriesLoading(true);
      final data = await HomeService.getCategories();
      if (data != null) {
        categories(data);
        return categories;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCategoriesLoading(false);
    }
  }

  Future<List<Category>?> getSubCategories({required String id}) async {
    try {
      isSubCategoriesLoading(true);
      final data = await HomeService.getSubCategories(id: id);
      if (data != null) {
        subCategories(data);
        return subCategories;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isSubCategoriesLoading(false);
    }
  }

  Future<List<Product>?> getCategoryproducts({required String id}) async {
    try {
      isCategoryProductsLoading(true);
      final data = await HomeService.getCategoryProducts(id: id);
      if (data != null) {
        if (id == '221') {
          offers(data);
          manageFavProducts(offers);
          return offers;
        }
        if (id == '107') {
          organicOliveOil(data);
          manageFavProducts(organicOliveOil);
          return organicOliveOil;
        }
        if (id == '225') {
          goldenOlive(data);
          manageFavProducts(goldenOlive);
          return goldenOlive;
        }
        if (id == '226') {
          jofoliaOliveOil(data);
          manageFavProducts(jofoliaOliveOil);
          return jofoliaOliveOil;
        }
        if (id == '166') {
          olive(data);
          manageFavProducts(olive);
          return olive;
        }
        if (id == '109') {
          honey(data);
          manageFavProducts(honey);
          return honey;
        }
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCategoryProductsLoading(false);
    }
  }

  manageFavProducts(List<Product> products) {
    for (var element in wishlistProducts) {
      for (var element2 in products) {
        if (element.id.toString() == element2.id.toString()) {
          element2.fav = true;
        }
      }
    }
  }

  Future<List<Product>?> getWishlistProducts({bool isFromHome = false}) async {
    try {
      isWishListProductsLoading(true);
      final data = await HomeService.getWishlistProducts();
      if (data != null) {
        wishlistProducts(data);
        if (wishlistProducts.isEmpty) {
          if (isFromHome) {
            getCategories();
            getSubCategories(id: '228');
            getCategoryproducts(id: '221');
            getCategoryproducts(id: '107');
            getCategoryproducts(id: '225');
            getCategoryproducts(id: '226');
            getCategoryproducts(id: '166');
            getCategoryproducts(id: '109');
          }
        } else {
          for (var element in wishlistProducts) {
            element.fav = true;
          }
          if (isFromHome) {
            getCategories();
            getSubCategories(id: '228');
            getCategoryproducts(id: '221');
            getCategoryproducts(id: '107');
            getCategoryproducts(id: '225');
            getCategoryproducts(id: '226');
            getCategoryproducts(id: '166');
            getCategoryproducts(id: '109');
          }
        }
        return wishlistProducts;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isWishListProductsLoading(false);
    }
  }

  Future<void> addToWishlist({
    required String id,
    required ProductController productController,
  }) async {
    for (var element in offers) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    for (var element in organicOliveOil) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    for (var element in goldenOlive) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    for (var element in jofoliaOliveOil) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    for (var element in olive) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    for (var element in honey) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    for (var element in productController.products) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    for (var element in productController.filteredProducts) {
      if (element.id.toString() == id) {
        element.fav = true;
        break;
      }
    }
    try {
      final isSuccess = await HomeService.addToWishlist(id: id);
      if (isSuccess) {
        getWishlistProducts();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFromWishlist({
    required String id,
    required ProductController productController,
  }) async {
    for (var element in offers) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    for (var element in organicOliveOil) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    for (var element in goldenOlive) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    for (var element in jofoliaOliveOil) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    for (var element in olive) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    for (var element in honey) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    for (var element in productController.products) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    for (var element in productController.filteredProducts) {
      if (element.id.toString() == id) {
        element.fav = false;
        break;
      }
    }
    try {
      final isSuccess = await HomeService.deleteFromWishlist(id: id);
      if (isSuccess) {
        getWishlistProducts();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> contactUs({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String enquiry,
  }) async {
    try {
      isContactUsLoading(true);
      final isSuccess = await HomeService.contactUs(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        enquiry: enquiry,
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isContactUsLoading(false);
    }
  }

  Future<Map<String, dynamic>?> getStaticPage({required String id}) async {
    try {
      isStaticPageLoading(true);
      final data = await HomeService.getStaticPage(id: id);
      if (data != null) {
        staticPageData(data);
        return staticPageData;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isStaticPageLoading(false);
    }
  }

  Future<List<Location>?> getLocations() async {
    try {
      isLocationsLoading(true);
      final data = await HomeService.getLocations();
      if (data != null) {
        locations(data);
        return locations;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isLocationsLoading(false);
    }
  }

  // ----------------------------------------------------------------

  Future<String?> createCoupon({
    required String customerId,
  }) async {
    try {
      isCreatingCouponLoading(true);
      final data = await HomeService.createCoupon(customerId: customerId);
      return data;
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCreatingCouponLoading(false);
    }
  }

  Future<String?> getCoupon() async {
    try {
      isCouponLoading(true);
      final data = await HomeService.getCoupon();
      if (data != null) {
        coupon(data);
        return coupon.value;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isCouponLoading(false);
    }
  }
}
