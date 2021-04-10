// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/message_list_screen/body.dart';
import 'package:help4you/screens/message_list_screen/app_bar.dart';

class MessageListScreen extends StatefulWidget {
  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: MessageListAppBar(),
        ),
        body: Body(),
      ),
    );
  }
}
