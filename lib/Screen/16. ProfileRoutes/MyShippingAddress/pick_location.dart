import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/string.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Widgets/action_button.dart';
import 'package:furniture_shop/Widgets/default_app_bar.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:furniture_shop/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PickLocation extends StatefulWidget {
  PickLocation();

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  MapboxMap? controller;
  CircleAnnotation? circleAnnotation;
  CircleAnnotationManager? circleAnnotationManager;
  int styleIndex = 1;

  double? x;
  double? y;

  Location location = new Location();
  LocationData? _locationData;
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    print('Hello');
    LocationData _locationData = await _location.getLocation();
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);
  }

  _onMapCreated(MapboxMap controller) async {
    controller.setBounds(CameraBoundsOptions(maxZoom: 20, minZoom: 5));
    controller.location.updateSettings(
        LocationComponentSettings(enabled: true, pulsingEnabled: true));
    controller.annotations.createCircleAnnotationManager().then((value) {
      circleAnnotationManager = value;
    });
    this.controller = controller;
    // this.controller?.flyTo(
    //     CameraOptions(
    //       center: Point(
    //               coordinates: Position(
    //                   _locationData!.longitude!, _locationData!.latitude!))
    //           .toJson(),
    //     ),
    //     MapAnimationOptions(duration: 1000));
  }

  _moveToCurrentLocation() async {
    final zoom = await controller?.getCameraState().then((value) => value.zoom);
    controller?.flyTo(
        CameraOptions(
          zoom: (zoom! < 12) ? 12 : null,
          center: Point(
                  coordinates: Position(
                      sharedPreferences.getDouble('longitude') ?? 0,
                      sharedPreferences.getDouble('latitude') ?? 0))
              .toJson(),
        ),
        MapAnimationOptions(duration: 1, startDelay: 0));
  }

  _onStyleLoadedCallback() async {}

  ///Place a circle annotation onTap and set Chosen location to tapped location
  _onTap(ScreenCoordinate coordinate) {
    //Deleting all existing annotations
    circleAnnotationManager?.deleteAll();
    //Create two overlapping circle annotations showing the tapped location
    circleAnnotationManager?.create(CircleAnnotationOptions(
        geometry:
            Point(coordinates: Position(coordinate.y, coordinate.x)).toJson(),
        circleColor: Colors.white.value,
        circleRadius: 10));
    circleAnnotationManager?.create(CircleAnnotationOptions(
        geometry:
            Point(coordinates: Position(coordinate.y, coordinate.x)).toJson(),
        circleColor: Colors.blue.value,
        circleRadius: 6));
    setState(() {
      x = coordinate.x;
      y = coordinate.y;
    });
    _reverseGeocoding(coordinate);
  }

  Future<String> _reverseGeocoding(ScreenCoordinate coordinates) async {
    final code = AppLocalization.of(context).locale.languageCode;
    final reponse = await http.get(Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${coordinates.x},${coordinates.y}.json?access_token=${mapBoxSecretToken}&language=${code}'));
    return reponse.body;
  }

  @override
  Widget build(BuildContext context) {
    final wMQ = MediaQuery.of(context).size.width;
    final hMQ = MediaQuery.of(context).size.height;
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   tooltip: 'Move to your current location',
        //   backgroundColor: AppColor.white,
        //   foregroundColor: AppColor.black,
        //   onPressed: _moveToCurrentLocation,
        //   child: Icon(Icons.my_location),
        // ),
        appBar: DefaultAppBar(context: context, title: "Pick a location"),
        body: Stack(children: [
          Column(children: [
            SizedBox(
              width: double.infinity,
              height: hMQ - 400,
              child: MapWidget(
                resourceOptions: ResourceOptions(
                  accessToken: mapBoxSecretToken,
                ),
                onMapCreated: (controller) => _onMapCreated(controller),
                cameraOptions: CameraOptions(
                    center: Point(
                            coordinates: Position(
                                sharedPreferences.getDouble('longitude') ?? 0,
                                sharedPreferences.getDouble('latitude') ?? 0))
                        .toJson(),
                    zoom: 12),
                onTapListener: _onTap,
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your current location:\n",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black),
                      ),
                      const Spacer(),
                      TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.topRight),
                          onPressed: () {
                            circleAnnotationManager?.deleteAll();
                            setState(() {
                              x = sharedPreferences.getDouble('longitude');
                              y = sharedPreferences.getDouble('latitude');
                            });
                          },
                          child: Text('Choose current location')),
                    ],
                  ),
                  Text(
                    ' ${sharedPreferences.getDouble('longitude')}, ${sharedPreferences.getDouble('latitude')}',
                    style: GoogleFonts.nunitoSans(
                        color: AppColor.text_secondary, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    'Chosen location:\n',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                  Text(
                    '${x ?? ''}, ${y ?? ''}',
                    style: GoogleFonts.nunitoSans(
                        color: AppColor.text_secondary, fontSize: 14),
                  ),
                  const Spacer(),
                  ActionButton(
                      boxShadow: [],
                      content: Text(
                        "Choose as your delivery address",
                        style: AppStyle.text_style_on_black_button,
                      ),
                      color: AppColor.black,
                      onPressed: () {})
                ],
              ),
            ))
          ]),
          Positioned(
            bottom: 315,
            right: 15,
            child: FloatingActionButton(
              tooltip: 'Move to your current location',
              backgroundColor: AppColor.white,
              foregroundColor: AppColor.black,
              onPressed: _moveToCurrentLocation,
              child: Icon(Icons.my_location),
            ),
          )
        ]));
  }
}
