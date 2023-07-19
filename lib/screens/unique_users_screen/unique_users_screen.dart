// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/create_booking_screens/new_address_screen.dart';
import 'package:help4you/screens/create_booking_screens/saved_address_screen.dart';
import 'package:help4you/screens/unique_users_screen/components/unique_users_tile.dart';

class UniqueUsersScreen extends StatefulWidget {
  final Set<String>? uniqueUsers;

  const UniqueUsersScreen({
    Key? key,
    this.uniqueUsers,
  }) : super(key: key);

  @override
  State<UniqueUsersScreen> createState() => _UniqueUsersScreenState();
}

class _UniqueUsersScreenState extends State<UniqueUsersScreen> {
  int? selected;

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: const SignatureButton(type: "Back Button"),
        title: Text(
          "Requested Professionals",
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.uniqueUsers?.length,
            itemBuilder: (context, index) {
              return UniqueUsersTile(
                uid: widget.uniqueUsers!.elementAt(index),
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
                index: index,
                selected: selected!,
              );
            },
          ),
          // ignore: unnecessary_null_comparison
          (selected != null)
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 50.0,
                  ),
                  child: SafeArea(
                    child: StreamBuilder(
                      stream: DatabaseService(uid: user!.uid).addressListData,
                      builder: (context, snapshot) {
                        List<Address>? addressData =
                            snapshot.data as List<Address>?;
                        return SignatureButton(
                          type: "Yellow",
                          onTap: () {
                            if (addressData!.isEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewAddressScreen(
                                    professionalUID: widget.uniqueUsers!
                                        .elementAt(selected!),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SavedAddressScreen(
                                    professionalUID: widget.uniqueUsers!
                                        .elementAt(selected!),
                                  ),
                                ),
                              );
                            }
                          },
                          text: "Select Professional",
                        );
                      },
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
