import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/controllers/fb_auth_controller.dart';
import 'package:firebaseapp/controllers/fb_firestore_controller.dart';
import 'package:firebaseapp/helpers/helpers.dart';
import 'package:firebaseapp/models/note.dart';
import 'package:firebaseapp/screens/note_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with Helpers{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3930D8),
        elevation: 0,
        centerTitle: true,
        title: Text('Home' ,
          style: TextStyle(color: Colors.white , fontFamily: 'Din' , fontSize: 22 , fontWeight: FontWeight.w600),),
        actions: [
          IconButton(onPressed: (){
             //navigate to  images screen
                Navigator.pushNamed(context, '/images_screen');
          }, icon: Icon(Icons.image)),
          IconButton(onPressed: () async{
            await FBAuthController().signOut();
            Navigator.pushReplacementNamed(context, '/login_screen');
          }, icon: Icon(Icons.logout, color:  Colors.white,)),


        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FbFirestoreController().read(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child:  CircularProgressIndicator(),);
          }else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context , index){

              return Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(

                    leading: const Icon(Icons.note),
                    title: Text(documents[index].get('title')),
                    subtitle: Text(documents[index].get('details')),
                    trailing: IconButton(
                      onPressed: () async =>
                      await delete(path: documents[index].id),
                      color: Colors.red.shade800,
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteScreen(
                            title: 'Update',
                            note: mapNote(documents[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );

            } , itemCount: documents.length,);
          }
          else{
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/nodata.png'),
                    SizedBox(height: 10,),
                    Text('No Notes :(', style: TextStyle(fontFamily: 'Din', fontSize: 22), ),
                    SizedBox(height: 10,),
                    Text('You have no task to do.' , style: TextStyle(fontFamily: 'Din', fontSize: 22),),
                  ],
                ),
            );
          }

        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff3930D8),
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context , MaterialPageRoute(builder: (context)=>NoteScreen()));
        },
      )
    );
  }


  Future<void> delete ({required String path}) async{
    bool deleted = await FbFirestoreController().delete(path: path);
    String message = deleted ? 'Note deleted successfuly' : 'Delete failed !' ;
    showSnackBar(context: context, message: message , error: !deleted);

  }

  Note mapNote(QueryDocumentSnapshot documentSnapshot){
      Note note = Note();
      note.id = documentSnapshot.id;
      note.title = documentSnapshot.get('title');
      note.details = documentSnapshot.get('details');

      return note;
  }
}
