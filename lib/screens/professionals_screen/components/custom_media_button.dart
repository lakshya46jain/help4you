// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports

class CustomMediaButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? color;
  final String? text;
  final String? title;

  const CustomMediaButton({
    Key? key,
    required this.onTap,
    this.icon,
    required this.color,
    this.text,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 75.0,
          width: 115.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F7),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(10.0),
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
              const SizedBox(height: 10.0),
              Text(
                title!,
                style: GoogleFonts.balooPaaji2(
                  height: 1.0,
                  fontSize: 18.0,
                  color: const Color(0xFF1C3857),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
