// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class ServiceTiles extends StatefulWidget {
  final String professionalUID;
  final String docId;
  final String serviceTitle;
  final String serviceDescription;
  final int servicePrice;

  ServiceTiles({
    @required this.professionalUID,
    @required this.docId,
    @required this.serviceTitle,
    @required this.serviceDescription,
    @required this.servicePrice,
  });

  @override
  _ServiceTilesState createState() => _ServiceTilesState();
}

class _ServiceTilesState extends State<ServiceTiles> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.serviceTitle,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.serviceDescription,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 7.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price : ${widget.servicePrice}",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2.5,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            FluentIcons.add_16_regular,
                            color: Colors.deepOrangeAccent,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}