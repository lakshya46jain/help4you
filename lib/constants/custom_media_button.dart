// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class CustomMediaButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String text;

  CustomMediaButton({
    @required this.onTap,
    @required this.icon,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 27.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: "BalooPaaji",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
