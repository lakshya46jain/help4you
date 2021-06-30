// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class CustomMediaButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final Color color;
  final String text;
  final String title;

  CustomMediaButton({
    @required this.onTap,
    this.icon,
    @required this.color,
    this.text,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 75.0,
          width: 115.0,
          decoration: BoxDecoration(
            color: Color(0xFFF2F3F7),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  color: color,
                  size: 27.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                title,
                style: TextStyle(
                  height: 1.0,
                  fontSize: 18.0,
                  color: Color(0xFF1C3857),
                  fontFamily: "BalooPaaji",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
