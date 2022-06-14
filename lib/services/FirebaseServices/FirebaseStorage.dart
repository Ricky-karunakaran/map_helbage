import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStor implements storage_service {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<bool> insert(String uid, String table, dynamic data) async {
    try {
      if (await db
          .collection(table)
          .doc(uid)
          .get()
          .then((value) => value.exists)) {
        throw Exception("Document Exist");
      }

      db.collection(table).doc(uid).set(data);
      final docRef = db.collection(table).doc(uid);
      if (docRef == null) {
        throw Exception();
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> add(String table, dynamic data) async {
    try {
      db.collection(table).add(data);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> update(String docid, String table, dynamic data) async {
    try {
      db
          .collection(table)
          .doc(docid)
          .update(data)
          .onError((error, stackTrace) => {throw Exception()});
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> delete(String docid, String table) async {
    try {
      db
          .collection(table)
          .doc(docid)
          .delete()
          .onError((error, stackTrace) => {throw Exception()});
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> read(
      String collection, String document) async {
    return db.collection(collection).doc(document).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readCollectionAsFuture(
      String collection) async {
    return db.collection(collection).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> readDocumentAsStream(
      String collection, String document) {
    return db.collection(collection).doc(document).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readCollectionAsStream(
      String collection) {
    return db.collection(collection).snapshots();
  }

  Future<void> insertLevel2(
      {required collection,
      required document,
      required subCollection,
      required subColDoc,
      required data}) async {
    //('schedule/Johor/Path').doc(data)
    db
        .collection(collection)
        .doc(document)
        .collection('Path')
        .doc(subColDoc)
        .set(data);
  }

  Future<void> newsSetup(String url) async {
    db.collection("news").add({'url': url, 'datetime': DateTime.now()});
  }
}
