import 'package:cloud_firestore/cloud_firestore.dart';

// Messages Model
class Messages {
  final String messageId;
  final String message;
  final Timestamp timeStamp;
  final String sender;

  Messages({
    this.messageId,
    this.message,
    this.timeStamp,
    this.sender,
  });
}
