import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _mediaFileList;
  Uint8List? _image;
  bool _loading = false;
  void _setImageFileListFromFile(XFile? value) async {
    _mediaFileList = value == null ? null : <XFile>[value];
    _image = await _mediaFileList!.first.readAsBytes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber.shade200,
        body: Center(
            child: _loading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FirebaseAuth.instance.currentUser?.photoURL != null
                          ? _image != null
                              ? Image.memory(_image!)
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(FirebaseAuth
                                      .instance.currentUser!.photoURL!),
                                )
                          : Text(FirebaseAuth.instance.currentUser?.photoURL ??
                              "No images"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: _selectPhoto,
                            child: const Text("Select photo")),
                      ),
                      if (_image != null)
                        ElevatedButton(
                            onPressed: _upload,
                            child: const Text("Upload to firebase storage"))
                    ],
                  )));
  }

  Future<void> _selectPhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _setImageFileListFromFile(pickedFile);
    });
  }

  Future<void> _upload() async {
    String filePath = _mediaFileList!.first.path;
    File file = File(filePath);
// Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final profileImageRef =
        storageRef.child(FirebaseAuth.instance.currentUser!.uid);
    try {
      setState(() {
        _loading = !_loading;
      });
      await profileImageRef.putFile(file);
      var url = await profileImageRef.getDownloadURL();
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      setState(() {
        _loading = !_loading;
        _image = null;
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
