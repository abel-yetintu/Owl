import 'dart:io';
import 'package:owl/models/owl_user.dart';
import 'package:owl/services/database_service.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  late final Reference _refrenceDirProfilePictures;

  StorageService() {
    _refrenceDirProfilePictures = _storage.ref('images/profile_pictures');
  }

  Future<bool> uploadProficePicture({required File file, required OwlUser owlUser}) async {
    try {
      var fileExtension = path.extension(file.path);
      if (fileExtension.isEmpty) {
        return false;
      }
      Reference refrenceImageToUpload = _refrenceDirProfilePictures.child('${owlUser.uid}_pp');
      await refrenceImageToUpload.putFile(file);
      var downloadUrl = await refrenceImageToUpload.getDownloadURL();
      var updatedUser = owlUser.copyWith(profilePicture: downloadUrl);
      DatabaseService().updateUser(owlUser: updatedUser);
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> removeProfilePicture({required OwlUser owlUser}) async {
    try {
      if (owlUser.profilePicture == '') {
        return true;
      } else {
        var updatedUser = owlUser.copyWith(profilePicture: '');
        DatabaseService().updateUser(owlUser: updatedUser);
        var refrenceImageToDelete = _refrenceDirProfilePictures.child('${owlUser.uid}_pp');
        await refrenceImageToDelete.delete();
        return true;
      }
    } catch (_) {
      rethrow;
    }
  }
}
