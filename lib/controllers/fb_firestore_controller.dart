import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/models/note.dart';

class FbFirestoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //CRUD
  Future<bool> create({required Note note}) async {
    return _firebaseFirestore
        .collection('Notes')
        .add(note.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> delete({required String path}) {
    return _firebaseFirestore
        .collection('Notes')
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> update({required Note note}) {
    return _firebaseFirestore
        .collection('Notes')
        .doc(note.id)
        .update(note.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }


  Stream<QuerySnapshot> read () async* {
   yield*  _firebaseFirestore.collection('Notes').snapshots();
  }
}
