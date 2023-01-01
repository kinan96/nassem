import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  MapController({this.mapAddressCoord, this.mapAddressController});
  @override
  void onInit() async {
    if (mapAddressCoord != null) {
      BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
      update();
      marker = [
        Marker(
          icon: icon,
          infoWindow: InfoWindow(title: mapAddressController?.text),
          position: mapAddressCoord ?? const LatLng(24.806863, 46.687762),
          markerId: const MarkerId("1"),
        )
      ];
      myLocation = mapAddressCoord;
    } else {
      getLocation();
    }
    super.onInit();
  }

  TextEditingController? mapAddressController = TextEditingController();

  LatLng? mapAddressCoord;

  List<Marker> marker = [];
  LatLng? myLocation;

  getLocation() async {
    myLocation = null;
    update();
    LocationData? locationResult;
    locationResult = await determinePosition();

    if (locationResult != null) {
      myLocation = LatLng(locationResult.latitude ?? 24.806863,
          locationResult.longitude ?? 46.687762);
    } else {
      myLocation = const LatLng(24.806863, 46.687762);
    }
    update();
    if (myLocation != null) {
      await addMarker(myLocation);
    }
  }

  addMarker(LatLng? p) async {
    if (p != null) {
      mapAddressCoord = p;
      try {
        EasyLoading.show();
        GeoCode geoCode = GeoCode();
        Address address = await geoCode.reverseGeocoding(
            latitude: p.latitude, longitude: p.longitude);
        EasyLoading.dismiss();

        marker = [
          Marker(
              position: p,
              markerId: const MarkerId("1"),
              infoWindow: InfoWindow(
                  title:
                      "${address.countryName == null ? "" : address.countryName.toString() + ", "}"
                      "${address.city == null ? "" : address.city.toString() + ", "}"
                      "${address.streetAddress ?? ""}")),
        ];

        mapAddressController = TextEditingController(
            text:
                "${address.countryName == null ? "" : address.countryName.toString() + ", "}"
                "${address.city == null ? "" : address.city.toString() + ", "}"
                "${address.streetAddress ?? ""}");
        update();
      } catch (e) {
        EasyLoading.dismiss();
      }
    }
  }

  late GoogleMapController mapController;
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LocationData?> determinePosition() async {
    try {
      Location location = Location();
      bool _serviceEnabled;
      LocationData _locationData;
      PermissionStatus _permissionGranted;
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      _locationData = await location.getLocation();
      return _locationData;
    } catch (e) {
      return null;
    }
  }
}
