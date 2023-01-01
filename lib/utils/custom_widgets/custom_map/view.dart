import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants/colors.dart';
import '../custom_text.dart';
import 'controller.dart';

class CustomMap extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  final bool onlyShow;
  final TextEditingController? mapAddressController;
  final LatLng? mapAddressCoord;
  const CustomMap(
      {Key? key,
      this.mapAddressCoord,
      this.mapAddressController,
      this.onlyShow = false,
      this.width,
      this.height,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: SizedBox(
        width: width,
        height: height,
        child: GetBuilder<MapController>(
            init: MapController(
                mapAddressController: mapAddressController,
                mapAddressCoord: mapAddressCoord),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () {
                  EasyLoading.dismiss();
                  Get.back(result: [mapAddressCoord, mapAddressController]);
                  return Future.value(false);
                },
                child: Scaffold(
                    body: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Stack(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: Get.height,
                          child: controller.mapAddressCoord == null
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText("search_location".tr),
                                      const CircularProgressIndicator(),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: Get.width,
                                  height: Get.height,
                                  child: GoogleMap(
                                    onTap: onlyShow
                                        ? null
                                        : (p) async {
                                            await controller.addMarker(p);
                                          },
                                    zoomControlsEnabled: false,
                                    myLocationButtonEnabled: false,
                                    mapToolbarEnabled: false,
                                    onMapCreated: controller.onMapCreated,
                                    markers: Set.from(controller.marker),
                                    initialCameraPosition: CameraPosition(
                                      target: controller.myLocation ??
                                          const LatLng(24.806863, 46.687762),
                                      zoom: 17.0,
                                    ),
                                  ),
                                )),
                      onlyShow
                          ? const SizedBox()
                          : Positioned(
                              top: MediaQuery.of(context).padding.top + 10,
                              right: 10,
                              child: SizedBox(
                                height: 30,
                                child: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    EasyLoading.dismiss();
                                    Get.back(result: [
                                      mapAddressCoord,
                                      mapAddressController
                                    ]);
                                  },
                                ),
                              ),
                            ),
                      onlyShow
                          ? const SizedBox()
                          : Positioned(
                              bottom: 20,
                              left: 20,
                              child: SizedBox(
                                width: Get.width - 40,
                                height: 80,
                                child: Row(
                                  children: [
                                    OutlinedButton(
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1)),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(40, 40))),
                                      child: const Icon(
                                        Icons.my_location_rounded,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () async {
                                        await controller.getLocation();
                                        if (controller.myLocation != null) {
                                          controller
                                              .mapController
                                              .moveCamera(CameraUpdate
                                                  .newCameraPosition(
                                                      CameraPosition(
                                                          target: controller
                                                                  .myLocation ??
                                                              controller
                                                                  .mapAddressCoord ??
                                                              const LatLng(
                                                                  24.806863,
                                                                  46.687762),
                                                          zoom: 17)));
                                        }
                                        EasyLoading.dismiss();
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: ElevatedButton(
                                      child: Text("save_location".tr),
                                      onPressed: () {
                                        EasyLoading.dismiss();
                                        Get.back(result: [
                                          controller.mapAddressCoord,
                                          controller.mapAddressController
                                        ]);
                                      },
                                    )),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                )),
              );
            }),
      ),
    );
  }
}
