// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String message;
  final String senderUid;
  final String receiverUid;
  final bool read;
  final Timestamp timeStamp;

  Message({
    required this.message,
    required this.senderUid,
    required this.receiverUid,
    required this.read,
    required this.timeStamp,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'read': read,
      'timeStamp': timeStamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      message: map['message'] as String,
      senderUid: map['senderUid'] as String,
      receiverUid: map['receiverUid'] as String,
      read: map['read'] as bool,
      timeStamp: map['timeStamp'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  Message copyWith({
    String? id,
    String? message,
    String? senderUid,
    String? receiverUid,
    bool? read,
    Timestamp? timeStamp,
  }) {
    return Message(
      id: id ?? this.id,
      message: message ?? this.message,
      senderUid: senderUid ?? this.senderUid,
      receiverUid: receiverUid ?? this.receiverUid,
      read: read ?? this.read,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
