// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:owl/models/message.dart';
import 'package:owl/models/owl_user.dart';

class Conversation {
  final String documentId;
  final Message lastMessage;
  final List<String> participantsUid;
  final List<OwlUser> participants;

  Conversation({required this.documentId, required this.lastMessage, required this.participantsUid, required this.participants});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documentId': documentId,
      'lastMessage': lastMessage.toMap(),
      'participantsUid': participantsUid,
      'participants': participants.map((x) => x.toMap()).toList(),
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      documentId: map['documentId'] as String,
      lastMessage: Message.fromMap(map['lastMessage'] as Map<String, dynamic>),
      participantsUid: List<String>.from(
        (map['participantsUid'] as List).map<String>(
          (e) => e as String,
        ),
      ),
      participants: List<OwlUser>.from(
        (map['participants'] as List).map<OwlUser>(
          (x) => OwlUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) => Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  Conversation copyWith({
    String? documentId,
    Message? lastMessage,
    List<String>? participantsUid,
    List<OwlUser>? participants,
  }) {
    return Conversation(
      documentId: documentId ?? this.documentId,
      lastMessage: lastMessage ?? this.lastMessage,
      participantsUid: participantsUid ?? this.participantsUid,
      participants: participants ?? this.participants,
    );
  }
}
