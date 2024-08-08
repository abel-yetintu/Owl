// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OwlUser {
  final String uid;
  final String email;
  final String userName;
  final String fullName;
  final String profilePicture;

  OwlUser({required this.uid, required this.email, required this.userName, required this.fullName, required this.profilePicture});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'userName': userName,
      'fullName': fullName,
      'profilePicture': profilePicture,
    };
  }

  factory OwlUser.fromMap(Map<String, dynamic> map) {
    return OwlUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      fullName: map['fullName'] as String,
      profilePicture: map['profilePicture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OwlUser.fromJson(String source) => OwlUser.fromMap(json.decode(source) as Map<String, dynamic>);

  OwlUser copyWith({
    String? uid,
    String? email,
    String? userName,
    String? fullName,
    String? profilePicture,
  }) {
    return OwlUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
