import 'package:firebaseapp/controllers/fb_firestore_controller.dart';
import 'package:firebaseapp/helpers/helpers.dart';
import 'package:firebaseapp/models/note.dart';
import 'package:flutter/material.dart';


class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, this.title ='Add Note  ' , this.note}) : super(key: key);
  final String title;
  final Note? note ;

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>  with Helpers{
  late TextEditingController _titleTextEditingController;
  late TextEditingController _detailsTextEditingController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _titleTextEditingController = TextEditingController(text: widget.note?.title ?? '');
    _detailsTextEditingController = TextEditingController(text:  widget.note?.details ?? '');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextEditingController.dispose();
    _detailsTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3930D8),
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text(widget.title, style: TextStyle(fontFamily: 'Din'), ),

      ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
        children: [
          TextField(
          controller: _titleTextEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Note Title'
            ),
            style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),
          ),
          
          Expanded(child: TextField(
          controller: _detailsTextEditingController,
            keyboardType: TextInputType.multiline,
            maxLines:  null,
            decoration: InputDecoration(
              border:  InputBorder.none,
              hintText: 'Type Something ...'
            ),
          )),


        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff3930D8),
        onPressed: () async=> await performProcess(), label: Text('Save Note' ),
    ));
  }

  Future<void> performProcess ()async {
    if(checkData()){
   await process();
    }



  }


  bool checkData(){
    if(_titleTextEditingController.text.isNotEmpty && _detailsTextEditingController.text.isNotEmpty){
      return true;

    }
    showSnackBar(context: context, message: 'Enter required Data' , error:  true );
    return false ;
  }
 Future<void> process() async {
   bool status =   widget.note == null ?  await FbFirestoreController().create(note: note) :await FbFirestoreController().update(note: note);
if(status){
  if(widget.note != null){
    Navigator.pop(context);
  }else{
    clear();
  }
}
   showSnackBar(context: context, message: status ? 'Process success'  :'Process failed' , error:  !status);
 }


 Note get note {
    Note note = widget.note == null ?   Note() : widget.note!;
     note.title = _titleTextEditingController.text;
     note.details = _detailsTextEditingController.text;
    return note;
 }

 void clear(){
    _titleTextEditingController.text = '';
    _detailsTextEditingController.text = '';
 }
}
