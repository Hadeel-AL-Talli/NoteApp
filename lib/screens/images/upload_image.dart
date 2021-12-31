import 'dart:io';

import 'package:firebaseapp/bloc/bloc/storage_bloc.dart';
import 'package:firebaseapp/bloc/events/storage_events.dart';
import 'package:firebaseapp/bloc/states/storage_states.dart';
import 'package:firebaseapp/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> with Helpers{
  ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedFile;
  double? _linearProgressValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Upload Image  ',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),

      ),
      body: BlocListener<StorageBloc , StorageStates>(
        listenWhen: (previous, current) => current is ProcessState && current.process == Process.create,

        listener: (context, state) {
          state as ProcessState ;
          showSnackBar(context: context, message: state.message , error:  !state.status);
          _changeProgressValue(value:  state.status? 1:0);
        },
        child: Column(
          children: [
            LinearProgressIndicator(
              minHeight: 10,
              color: Colors.green,
              backgroundColor: Colors.blue.shade200,
              value: _linearProgressValue,
            ),
            Expanded(
              child: _pickedFile != null
                  ? Image.file(File(_pickedFile!.path))
                  : TextButton(
                onPressed: () async {
                 await  _pickImage();
                } ,
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: const Text("Pick Image"),
              ),
            ),
            ElevatedButton.icon(
             onPressed: () async => await performUpload(),

              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              icon: const Icon(Icons.cloud_upload),
              label: const Text(
                'UPLOAD',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (imageFile != null) {
      setState(() {
        _pickedFile = imageFile;
      });
    }
  }

  Future<void> performUpload() async {
    if (checkData()) {
      await uploadImage();
    }
  }

  bool checkData() {
    if (_pickedFile != null) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Select image to upload',
      error: true,
    );
    return false;
  }
  Future<void> uploadImage() async {
    _changeProgressValue(value: null);
    BlocProvider.of<StorageBloc>(context).add(CreateEvent(_pickedFile!.path));
  }

  void _changeProgressValue({double? value}) {
    setState(() {
      _linearProgressValue = value;
    });
  }
}
