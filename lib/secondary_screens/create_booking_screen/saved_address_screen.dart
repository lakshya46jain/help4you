// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/secondary_screens/create_booking_screen/add_address_screen.dart';
import 'package:help4you/secondary_screens/create_booking_screen/saved_address_tile.dart';
import 'package:help4you/secondary_screens/create_booking_screen/timings_screens_screen.dart';

class SavedAddressScreen extends StatefulWidget {
  @override
  _SavedAddressScreenState createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  int selected;

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: CustomBackButton(),
        title: Text(
          "Address Options",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              FluentIcons.add_24_filled,
              size: 25.0,
              color: Color(0xFFFEA700),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAddressScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseService(uid: user.uid).addressListData,
        builder: (context, snapshot) {
          List<Address> addressOptions = snapshot.data;
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  physics: BouncingScrollPhysics(),
                  itemCount: addressOptions.length,
                  itemBuilder: (context, index) {
                    return SavedAddressTile(
                      uid: user.uid,
                      addressId: addressOptions[index].addressId,
                      addressName: addressOptions[index].addressName,
                      completeAddress: addressOptions[index].completeAddress,
                      addressType: addressOptions[index].addressType,
                      geoPointLocation: addressOptions[index].geoPoint,
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      index: index,
                      selected: selected,
                    );
                  },
                ),
                (selected != null)
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 50.0,
                        ),
                        child: SafeArea(
                          child: SignatureButton(
                            type: "Yellow",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TimingsScreen(
                                    completeAddress: addressOptions[selected]
                                        .completeAddress,
                                    geoPointLocation:
                                        addressOptions[selected].geoPoint,
                                  ),
                                ),
                              );
                            },
                            text: "Select Address",
                          ),
                        ),
                      )
                    : Container(
                        height: 0.0,
                        width: 0.0,
                      ),
              ],
            );
          } else {
            return DoubleBounceLoading();
          }
        },
      ),
    );
  }
}
