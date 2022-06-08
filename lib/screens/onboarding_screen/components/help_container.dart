// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class HelpContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function onTap;
  final String buttonText;

  const HelpContainer({
    Key key,
    this.icon,
    this.title,
    this.description,
    this.onTap,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.75,
          color: Colors.black.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24.0,
            color: Colors.black,
          ),
          const SizedBox(height: 15.0),
          Text(
            title,
            style: const TextStyle(
              height: 1.3,
              fontSize: 19.0,
              color: Colors.black,
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            style: TextStyle(
              height: 1.3,
              fontSize: 16.0,
              color: Colors.black.withOpacity(0.5),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.normal,
            ),
          ),
          Divider(
            height: 40.0,
            color: Colors.black.withOpacity(0.3),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              buttonText,
              style: const TextStyle(
                height: 1.3,
                fontSize: 16.0,
                color: Colors.blueAccent,
                fontFamily: "BalooPaaji",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
