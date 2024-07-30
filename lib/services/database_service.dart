import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owl/models/owl_user.dart';

class DatabaseService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  late final CollectionReference<OwlUser> _usersCollection;

  DatabaseService() {
    _usersCollection = _database.collection('users').withConverter<OwlUser>(
          toFirestore: (value, _) => value.toMap(),
          fromFirestore: (snapshot, _) => OwlUser.fromMap(snapshot.data()!),
        );
  }

  Future<void> createUserDocument({required OwlUser owlUser}) async {
    try {
      await _usersCollection.doc(owlUser.uid).set(owlUser);
    } catch (_) {
      rethrow;
    }
  }

  Future<OwlUser> getOwlUser({required String uid}) async {
    try {
      final owlUser = (await _usersCollection.doc(uid).get()).data()!;
      return owlUser;
    } catch (_) {
      rethrow;
    }
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
}
