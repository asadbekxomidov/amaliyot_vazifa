import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagesFirebaseServices {
  final _imagesCollection = FirebaseFirestore.instance.collection("images");
  final _imageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getImage() async* {
    yield* _imagesCollection.snapshots();
  }

  Future<void> addImage(String name, File imageFile) async {
    final imageReference = _imageStorage
        .ref()
        .child("images")
        .child("$name.jpg");
    final uploadTask = imageReference.putFile(
      imageFile,
    );

    uploadTask.snapshotEvents.listen((status) {
      print(status.state);

      double percentage =
          (status.bytesTransferred / imageFile.lengthSync()) * 100;

      print("$percentage%");
    });

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();
      await _imagesCollection.add({
        "name": name,
        "imageUrl": imageUrl,
      });
    });
  }

   Future<void> editImage(String id, String newName, File? newImageFile) async {
    if (newImageFile != null) {
      final imageReference = _imageStorage
          .ref()
          .child("cars")
          .child("images")
          .child("$newName.jpg");
      final uploadTask = imageReference.putFile(newImageFile);

      uploadTask.snapshotEvents.listen((status) {
        print(status.state);
        double percentage = (status.bytesTransferred / newImageFile.lengthSync()) * 100;
        print("$percentage%");
      });

      await uploadTask.whenComplete(() async {
        final imageUrl = await imageReference.getDownloadURL();
        await _imagesCollection.doc(id).update({
          "name": newName,
          "imageUrl": imageUrl,
        });
      });
    } else {
      await _imagesCollection.doc(id).update({
        "name": newName,
      });
    }
  }

  Future<void> deleteImage(String id) async {
    final document = await _imagesCollection.doc(id).get();
    final imageUrl = document['imageUrl'];
    final imageReference = _imageStorage.refFromURL(imageUrl);
    await imageReference.delete();
    await _imagesCollection.doc(id).delete();
  }
}
