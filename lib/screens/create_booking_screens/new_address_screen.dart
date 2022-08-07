// Flutter Imports
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/signature_button.dart';

class NewAddressScreen extends StatefulWidget {
  final String professionalUID;

  const NewAddressScreen({
    Key key,
    @required this.professionalUID,
  }) : super(key: key);

  @override
  NewAddressScreenState createState() => NewAddressScreenState();
}

class NewAddressScreenState extends State<NewAddressScreen> {
  // Google Maps Variables
  double latitude;
  double longitude;
  Position currentPosition;
  GoogleMapController newGoogleMapsController;
  Completer<GoogleMapController> googleMapsController = Completer();
  static const CameraPosition googlePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers = {};

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    latitude = position.latitude;
    longitude = position.longitude;
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapsController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    Marker myLocationMarker = Marker(
      markerId: const MarkerId("My Location"),
      position: latLngPosition,
      icon: BitmapDescriptor.defaultMarker,
    );
    setState(() {
      markers.add(myLocationMarker);
    });
  }

  // Custom Radio Button
  int selected = 0;

  // Variables
  String addressName;
  String completeAddress;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget customRadioButton(int index, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 7.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            color: (index == selected) ? Colors.white : const Color(0xFF1C3857),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: (index == selected)
                    ? const Color(0xFF1C3857)
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getPermission() async {
    var locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      Permission.location.request();
    } else if (locationStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: SignatureButton(type: "Back Button"),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    CupertinoIcons.location,
                    size: 25.0,
                    color: Color(0xFFFEA700),
                  ),
                  onPressed: () async {
                    locatePosition();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        parallaxOffset: 0.75,
        parallaxEnabled: true,
        color: Colors.transparent,
        panel: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: const EdgeInsets.only(
              top: 15.0,
              left: 25.0,
              right: 25.0,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF1C3857),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: 75.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      "Add Address",
                      style: GoogleFonts.balooPaaji2(
                        height: 1.0,
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Add a Name for the Address*",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.55),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          addressName = value;
                        });
                      },
                    ),
                    const SizedBox(height: 35.0),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Complete Address*",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.55),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          completeAddress = value;
                        });
                      },
                    ),
                    const SizedBox(height: 35.0),
                    Row(
                      children: [
                        customRadioButton(0, "Home"),
                        customRadioButton(1, "Office"),
                        customRadioButton(2, "Other"),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    SignatureButton(
                      onTap: () async {
                        if (formKey.currentState.validate()) {
                          FocusScope.of(context).unfocus();
                          GeoPoint geoPoint = GeoPoint(latitude, longitude);
                          await DatabaseService(uid: user.uid)
                              .addAdress(
                                geoPoint,
                                addressName,
                                completeAddress,
                                selected,
                              )
                              .then(
                                (value) => Navigator.pop(context),
                              );
                        }
                      },
                      text: "Save and Proceed",
                      withIcon: false,
                      type: "Yellow",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: GoogleMap(
          markers: markers,
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: googlePlex,
          onMapCreated: (GoogleMapController controller) {
            googleMapsController.complete(controller);
            newGoogleMapsController = controller;
            locatePosition();
          },
        ),
      ),
    );
  }
}
