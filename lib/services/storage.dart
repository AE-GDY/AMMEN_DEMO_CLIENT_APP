import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';

import 'package:image_picker/image_picker.dart';


class Storage{

  // Firebase storage instance
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;


  // Function to upload file to firebase storage
  Future<void> uploadFile(String folderName,String fileName, String filePath) async {

    File file = File(filePath);

    try{
      await storage.ref('$folderName/$fileName').putFile(file);
    }
    on firebase_core.FirebaseException catch (e){
      print(e);
    }

  }

  // Function to load image from firebase storage
  Future<String> getImage(String folderName,String fileName) async {

    String downloadUrl = await storage.ref('$folderName/$fileName').getDownloadURL();
    print("download url: $downloadUrl");
    return downloadUrl;

  }
}