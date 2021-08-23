// Flutter Imports
import 'dart:async';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/secondary_screens/create_booking_screen/timings_screens_screen.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  // Google Maps Variables
  double latitude;
  double longitude;
  Position currentPosition;
  GoogleMapController newGoogleMapsController;
  Completer<GoogleMapController> googleMapsController = Completer();
  static final CameraPosition googlePlex = CameraPosition(
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
      markerId: MarkerId("My Location"),
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
  String addressType;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget customRadioButton(int index, String text) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 7.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            color: (index == selected) ? Colors.white : Color(0xFF1C3857),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: (index == selected) ? Color(0xFF1C3857) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
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
          padding: EdgeInsets.only(left: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomBackButton(),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    FluentIcons.my_location_24_regular,
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
        maxHeight: 425.0,
        parallaxEnabled: true,
        parallaxOffset: 0.75,
        panel: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 15.0,
              left: 25.0,
              right: 25.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF1C3857),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
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
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Add Address",
                    style: TextStyle(
                      height: 1.0,
                      fontSize: 30.0,
                      color: Colors.white,
                      fontFamily: "BalooPaaji",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Add a Name for the Address*",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                      ),
                      focusedBorder: UnderlineInputBorder(
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
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Complete Address*",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                      ),
                      focusedBorder: UnderlineInputBorder(
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
                  SizedBox(
                    height: 35.0,
                  ),
                  Row(
                    children: [
                      customRadioButton(0, "Home"),
                      customRadioButton(1, "Office"),
                      customRadioButton(2, "Other"),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SignatureButton(
                    onTap: () async {
                      if (formKey.currentState.validate()) {
                        FocusScope.of(context).unfocus();
                        if (selected == 0) {
                          setState(() {
                            addressType = "Home";
                          });
                        } else if (selected == 1) {
                          setState(() {
                            addressType = "Office";
                          });
                        } else if (selected == 2) {
                          setState(() {
                            addressType = "Other";
                          });
                        }
                        await DatabaseService(uid: user.uid).addAdress(
                          latitude,
                          longitude,
                          addressName,
                          completeAddress,
                          addressType,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimingsScreen(),
                          ),
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