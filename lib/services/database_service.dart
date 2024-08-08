import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owl/models/conversation.dart';
import 'package:owl/models/message.dart';
import 'package:owl/models/owl_user.dart';

class DatabaseService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  late final CollectionReference<OwlUser> _usersCollection;
  late final CollectionReference<Conversation> _conversationsCollection;

  DatabaseService() {
    _usersCollection = _database.collection('users').withConverter<OwlUser>(
          toFirestore: (value, _) => value.toMap(),
          fromFirestore: (snapshot, _) => OwlUser.fromMap(snapshot.data()!),
        );
    _conversationsCollection = _database.collection('conversations').withConverter<Conversation>(
          toFirestore: (value, _) => value.toMap(),
          fromFirestore: (snapshot, _) => Conversation.fromMap(snapshot.data()!),
        );
  }

  Future<void> createUserDocument({required OwlUser owlUser}) async {
    try {
      await _usersCollection.doc(owlUser.uid).set(owlUser);
    } catch (_) {
      rethrow;
    }
  }

  Stream<OwlUser?> getOwlUser({required String uid}) {
    return _usersCollection.doc(uid).snapshots().map((doc) => doc.data());
  }

  Future<bool> isUserNameAvailable({required String userName}) async {
    try {
      final querySnapshot = await _usersCollection.where('userName', isEqualTo: userName).get();
      return querySnapshot.docs.isEmpty;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<OwlUser>> getOwlUsers() async {
    try {
      final querySnapshot = (await _usersCollection.get()).docs;
      if (querySnapshot.isEmpty) {
        return [];
      } else {
        final owlUsers = querySnapshot.map((doc) => doc.data()).toList();
        return owlUsers;
      }
    } catch (_) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Conversation>> getConversations({required String uid}) {
    return _conversationsCollection
        .where('participantsUid', arrayContains: uid)
        .orderBy('lastMessage.timeStamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(
      {required OwlUser currentUser, required OwlUser otherUser, required Message message, required String docId}) async {
    try {
      var conversation = Conversation(
        documentId: docId,
        lastMessage: message,
        participantsUid: [currentUser.uid, otherUser.uid],
        participants: [currentUser, otherUser],
      );
      await _database.runTransaction((Transaction transaction) async {
        var conversationRef = _conversationsCollection.doc(docId);
        var messageRef = _conversationsCollection.doc(docId).collection('messages').doc(message.id);

        transaction.set(conversationRef, conversation);
        transaction.set(messageRef, message.toMap());
      });
    } catch (_) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({required String docId}) {
    return _conversationsCollection.doc(docId).collection('messages').snapshots();
  }

  Future<void> markMessageAsRead({required Message message, required String docId}) async {
    try {
      await _database.runTransaction((Transaction transaction) async {
        var conversationRef = _conversationsCollection.doc(docId);
        var messageRef = _conversationsCollection.doc(docId).collection('messages').doc(message.id);

        var convo = (await transaction.get(conversationRef)).data()!;
        transaction.set(
          messageRef,
          <String, dynamic>{'read': true},
          SetOptions(merge: true),
        );
        if (convo.lastMessage.id == message.id) {
          transaction.set(
            conversationRef,
            convo.copyWith(lastMessage: message.copyWith(read: true)),
            SetOptions(merge: true),
          );
        }
      });
    } catch (e) {
      print('MarkAsRead: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> updateUser({required OwlUser owlUser}) async {
    try {
      await _database.runTransaction((Transaction transaction) async {
        var userReference = _usersCollection.doc(owlUser.uid);
        transaction.update(userReference, owlUser.toMap());

        var docs = (await _conversationsCollection.where('participantsUid', arrayContains: owlUser.uid).get()).docs;
        var conversations = docs.map((doc) => doc.data()).toList();
        var updatedConversations = conversations.map((conversation) {
          var otherUser = conversation.participants.singleWhere((user) => user.uid != owlUser.uid);
          return conversation.copyWith(participants: [owlUser, otherUser]);
        }).toList();

        for (var conversation in updatedConversations) {
          var documentReference = _conversationsCollection.doc(conversation.documentId);
          transaction.update(documentReference, conversation.toMap());
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
