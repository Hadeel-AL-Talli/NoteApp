import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
typedef FbUploadListener = void Function({String? message ,Reference? reference ,  required TaskState taskState , required bool status});
class FbStorageController {
FirebaseStorage _firebaseStorage = FirebaseStorage.instance;



Future<void> uploadImage({required String path, required FbUploadListener fbUploadListener}) async{
UploadTask uploadTask =   _firebaseStorage.ref('images/'+DateTime.now().toString() + '_image').putFile(File(path));

uploadTask.snapshotEvents.listen((event) {
  if(event.state == TaskState.running){
        fbUploadListener(status: false , taskState: event.state);
  }else if (event.state == TaskState.success){
    fbUploadListener(status: true, reference: event.ref, taskState: event.state , message:  'Image uploaded successfully');
  } else if (event.state == TaskState.error){
     fbUploadListener(status: false , taskState: TaskState.error , message: 'Faild to upload image,try again ');
  }

});
}


Future<List<Reference>> read ()async {
ListResult listResult  = await _firebaseStorage.ref('images').listAll();
if(listResult.items.isNotEmpty){
  return listResult.items;
}
return [];
}


Future<bool> delete ({required String path}){
  return _firebaseStorage.ref(path).delete().then((value) => true).catchError((error)=>false);
}
}