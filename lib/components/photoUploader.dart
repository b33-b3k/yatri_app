import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploader {
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://saha-yatri-fef25.appspot.com');
  final ImagePicker _picker = ImagePicker();

  Future<String?> capturePhotoAndUploadToFirestore() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      return null;
    }

    File file = File(pickedFile.path);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      await _storage.ref().child('images/$fileName').putFile(file);
      return fileName;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> selectPhotoAndUploadToFirestore() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    }

    File file = File(pickedFile.path);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      await _storage.ref().child('images/$fileName').putFile(file);
      return fileName;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> getPhotoUrl(String fileName) async {
    try {
      final ref = _storage.ref().child('images/$fileName');
      final uri = await ref.getDownloadURL();
      return uri;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class PhotoUpload extends StatefulWidget {
  PhotoUpload({super.key, required this.title});

  final String title;

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  String? _uploadedPhotoUrl;
  final PhotoUploader _photoUploader = PhotoUploader();

  void _capturePhotoAndUpload() async {
    final fileName = await _photoUploader.capturePhotoAndUploadToFirestore();
    if (fileName != null) {
      final url = await _photoUploader.getPhotoUrl(fileName);
      setState(() {
        _uploadedPhotoUrl = url.toString();
      });
    }
  }

  void _selectPhotoAndUpload() async {
    final fileName = await _photoUploader.selectPhotoAndUploadToFirestore();
    if (fileName != null) {
      final url = await _photoUploader.getPhotoUrl(fileName);
      setState(() {
        _uploadedPhotoUrl = url.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //image network

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _uploadedPhotoUrl != null
                ? Image.network(
                    _uploadedPhotoUrl!,
                    height: 200,
                  )
                : Container(),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Capture Photo and Upload'),
              onPressed: _capturePhotoAndUpload,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Select Photo and Upload'),
              onPressed: _selectPhotoAndUpload,
            ),
          ],
        ),
      ),
    );
  }
}
