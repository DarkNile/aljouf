import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/profile/view/add_address_screen.dart';
import 'package:aljouf/profile/view/edit_address_screen.dart';
import 'package:aljouf/profile/view/widgets/address_card.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_header.dart';
import 'package:aljouf/widgets/custom_text.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getAddress(context: context);
      _profileController.getCountries();
      _profileController.getZones();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeader(title: 'myAddresses'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBodyTitle(
            title: 'myDeliveryAddresses'.tr,
          ),
          const SizedBox(
            height: 36,
          ),
          Obx(() {
            if (_profileController.isAddressLoading.value ||
                _profileController.isCountriesLoading.value ||
                _profileController.isZonesLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (_profileController.addresses.isEmpty) {
              return Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: darkGrey,
                            ),
                            alignment: Alignment.center,
                            child:
                                SvgPicture.asset('assets/icons/location.svg'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomText(
                            text: 'noAddress'.tr,
                            color: warmGrey,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const AddAddressScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: almostBlack,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Expanded(
              child: Stack(children: [
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(bottom: 32),
                  itemCount: _profileController.addresses.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 24,
                    );
                  },
                  itemBuilder: (context, index) {
                    return AddressCard(
                      phoneNumber: _profileController.user.value.phone!,
                      address: _profileController.addresses[index],
                      length: _profileController.addresses.length,
                      onEditTap: () {
                        _profileController.getCitiesByZoneId(
                          zoneId: _profileController.addresses[index].zoneId,
                        );
                        Get.to(
                          () => EditAddressScreen(
                            address: _profileController.addresses[index],
                          ),
                        );
                      },
                      onDeleteTap: () async {
                        final isSuccess =
                            await _profileController.deleteAddress(
                          id: _profileController.addresses[index].id,
                          context: context,
                        );
                        if (isSuccess) {
                          setState(() {
                            _profileController.addresses
                                .remove(_profileController.addresses[index]);
                          });
                        }
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const AddAddressScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: almostBlack,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ),
                ),
              ]),
            );
          }),
        ],
      ),
    );
  }
}
