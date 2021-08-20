// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class SignatureButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData icon;
  final bool withIcon;
  final String type;

  SignatureButton({
    @required this.onTap,
    @required this.text,
    this.icon,
    @required this.withIcon,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: (type == "Yellow") ? Color(0xFFFEA700) : Color(0xFF1C3857),
        ),
        width: double.infinity,
        height: 60.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: (withIcon == true)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: (type == "Yellow")
                              ? FontWeight.w600
                              : FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: (type == "Yellow")
                          ? FontWeight.w600
                          : FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
