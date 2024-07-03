import 'dart:io';

import 'package:amaliyot_vazifa/services/images_firebase_servises.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImagesController with ChangeNotifier {
  final _imagesFirebaseServices = ImagesFirebaseServices();

  Stream<QuerySnapshot> get list async* {
    yield* _imagesFirebaseServices.getImage();
  }

  Future<void> addImage(String name, File imageFile) async {
    await _imagesFirebaseServices.addImage(name, imageFile);
    notifyListeners();
  }

  Future<void> editImage(String id, String newName, File? newImageFile) async {
    await _imagesFirebaseServices.editImage(id, newName, newImageFile);
  }

  Future<void> deleteImage(String id) async {
    await _imagesFirebaseServices.deleteImage(id);
  }
}
