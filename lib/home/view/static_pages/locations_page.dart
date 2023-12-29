import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/widgets/custom_header.dart';
import 'package:aljouf/widgets/custom_loading_widget.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeader(title: 'exhibitionBranches'.tr),
      body: Obx(() {
        if (homeController.isLocationsLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            padding: const EdgeInsets.all(16),
            itemCount: homeController.locations.length,
            itemBuilder: (context, index) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: warmGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                onTap: () async {
                  await launchUrlString(
                      homeController.locations[index].geocode!);
                },
                title: CustomText(
                  text: homeController.locations[index].name!,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: CustomText(
                  text: homeController.locations[index].address!,
                  fontSize: 12,
                  color: brownishGrey,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: homeController.locations[index].image != null
                      ? CachedNetworkImage(
                          imageUrl: homeController.locations[index].image!,
                          placeholder: (context, url) {
                            return const CustomLoadingWidget();
                          },
                        )
                      : const Icon(Icons.home),
                ),
                trailing: const Icon(
                  Icons.location_on,
                  color: black,
                ),
              );
            });
      }),
    );
  }
}
