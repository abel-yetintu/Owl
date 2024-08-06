String generateDocumentId({required String uid1, required String uid2}) {
  List<String> uids = [uid1, uid2];
  uids.sort();
  String documentId = uids.fold('', (id, uid) => '$id$uid');
  return documentId;
}
