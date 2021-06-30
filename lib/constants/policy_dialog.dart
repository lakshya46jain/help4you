// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:flutter_markdown/flutter_markdown.dart';
// File Imports
import 'package:help4you/constants/signature_button.dart';

class PolicyDialog extends StatelessWidget {
  PolicyDialog({
    Key key,
    this.radius = 10,
    @required this.mdFileName,
  })  : assert(
          mdFileName.contains('.md'),
          'The file must contain the .md extension',
        ),
        super(key: key);

  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then(
                (value) {
                  return rootBundle.loadString(
                    'assets/files/$mdFileName',
                  );
                },
              ),
              builder: (context, snapshot) {
                return Markdown(
                  data: snapshot.data,
                );
              },
            ),
          ),
          SignatureButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: "CLOSE",
            withIcon: false,
          ),
        ],
      ),
    );
  }
}
