import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebaseapp/bloc/bloc/storage_bloc.dart';
import 'package:firebaseapp/bloc/events/storage_events.dart';
import 'package:firebaseapp/bloc/states/storage_states.dart';
import 'package:firebaseapp/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<StorageBloc>(context).add(ReadEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Images ',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        actions: [
             IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/upload_image');
             }, icon: Icon(Icons.cloud_upload), color: Colors.black,)
        ],
      ),

      body: BlocConsumer<StorageBloc , StorageStates>(
        listenWhen: (previous, current) =>
             current is ProcessState && current.process  == Process.delete,


          listener: (context, state) {
             state as ProcessState;
showSnackBar(context: context, message: state.message , error:  !state.status);
          },
          buildWhen: (previous, current) =>
         current is ReadState ||current is LoadingState,

          builder: (context, state) {

              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReadState && state.references.isNotEmpty) {
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: state.references.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FutureBuilder<String>(
                        future: state.references[index].getDownloadURL(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            print('URL: ${snapshot.data!}');
                            return Stack(
                              children: [
                                CachedNetworkImage(
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  cacheKey: state.references[index].fullPath,
                                  imageUrl: snapshot.data!,
                                  placeholder: (context, url) =>
                                      Center(child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    color: Colors.black38,
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: IconButton(
                                      onPressed: () => deleteImage(
                                          filePath:
                                          state.references[index].fullPath),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: Icon(Icons.image, size: 50),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.warning,
                        size: 90,
                        color: Colors.grey,
                      ),
                      Text(
                        'NO DATA',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                );
              }

      }),
    );
  }



  Future<void> deleteImage ({required String filePath }) async {
    BlocProvider.of<StorageBloc>(context).add(DeleteEvent(filePath));
  }
}
