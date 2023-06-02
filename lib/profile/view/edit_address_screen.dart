import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/profile/models/address.dart';
import 'package:aljouf/profile/models/city.dart';
import 'package:aljouf/profile/models/zone.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_drop_down.dart';
import 'package:aljouf/widgets/custom_header.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key, required this.address});

  final Address address;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _districtController;
  late Zone? zone;
  City? city;
  bool isZoneChanged = false;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.address.firstName);
    _lastNameController = TextEditingController(text: widget.address.lastName);
    _districtController = TextEditingController(text: widget.address.address);
    zone = _profileController.zones
        .firstWhere((e) => e.zoneId == widget.address.zoneId);
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _districtController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeader(title: 'editAddress'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomBodyTitle(
              title: 'editAddress'.tr,
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'firstName'.tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              CustomTextField(
                                controller: _firstNameController,
                                hintText: 'firstName'.tr,
                                textInputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'lastName'.tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              CustomTextField(
                                controller: _lastNameController,
                                hintText: 'lastName'.tr,
                                textInputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'country'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextField(
                      initialValue: 'Saudia Arabia'.tr,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'zone'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomDropDown(
                        value: zone,
                        hintText: 'zone'.tr,
                        items: _profileController.zones,
                        onChanged: (value) {
                          zone = value;
                          isZoneChanged = true;
                          _profileController.getCitiesByZoneId(
                              zoneId: zone!.zoneId);
                        }),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'city'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      if (_profileController.isCitiesLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      city = isZoneChanged
                          ? null
                          : _profileController.cities.firstWhereOrNull((e) =>
                              e.name == widget.address.city ||
                              e.nameAr == widget.address.city);
                      return CustomDropDown(
                          value: city,
                          hintText: 'city'.tr,
                          items: _profileController.cities,
                          onChanged: (value) {
                            city = value;
                          });
                    }),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'district'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    CustomTextField(
                      controller: _districtController,
                      hintText: 'district'.tr,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(() {
                      if (_profileController.isEditingAddress.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                        radius: 4,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final isSuccess =
                                await _profileController.editAddress(
                              id: widget.address.id,
                              context: context,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              city: city!.name,
                              address: _districtController.text,
                              countryId: 184,
                              zoneId: int.parse(zone!.zoneId),
                            );
                            if (isSuccess) {
                              Get.back();
                            }
                          }
                        },
                        title: 'save'.tr,
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
          ],
        ),
      ),
    );
  }
}
