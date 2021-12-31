import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseapp/bloc/events/storage_events.dart';
import 'package:firebaseapp/bloc/states/storage_states.dart';
import 'package:firebaseapp/controllers/fb_storage_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageBloc extends Bloc<StorageEvents, StorageStates>{

  List<Reference> _reference = <Reference> [];
 final  FbStorageController _fbStorageController = FbStorageController();
StorageBloc(StorageStates initialState) : super (initialState){
  on<CreateEvent>(_onCreateEvent);
  on<ReadEvent>(_onReadEvent);
  on<DeleteEvent>(_onDeleteEvent);
}


void _onCreateEvent (CreateEvent event , Emitter emitter ){
_fbStorageController.uploadImage(path: event.filePath, fbUploadListener: ({String? message,Reference? reference,required bool status,  required TaskState taskState}) {
  if(taskState == TaskState.error){
    emit( ProcessState(false , message! , Process.create));
  } else if(taskState == TaskState.success){
      emit( ProcessState(true , message! , Process.create));
      if(reference != null ){
         _reference.add(reference);
         emit(ReadState(_reference));
      }

  }

},);

}
void _onReadEvent (ReadEvent event , Emitter emitter ) async{
List<Reference> references = await _fbStorageController.read();
_reference = references ;
emit(ReadState(_reference));

}

void _onDeleteEvent ( DeleteEvent event, Emitter emitter ) async{

bool deleted = await _fbStorageController.delete(path: event.filPath);
if(deleted){
int index = _reference.indexWhere((element) => element.fullPath == event.filPath);
if(index != -1){
  _reference.removeAt(index);
  emit(ReadState(_reference));
}
}
emit(ProcessState(deleted ,deleted ? 'Deleted Successfully' : 'Delete faild' , Process.delete));
}


}