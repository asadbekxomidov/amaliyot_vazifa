import 'dart:io';

import 'package:amaliyot_vazifa/controllers/images_controller.dart';
import 'package:amaliyot_vazifa/utils/masseges.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ManageImages extends StatefulWidget {
  const ManageImages({super.key});

  @override
  State<ManageImages> createState() => _ManageImagesState();
}

class _ManageImagesState extends State<ManageImages> {
  final nameController = TextEditingController();
  File? imageFile;

  void addCar() async {
    if (imageFile != null && nameController.text.isNotEmpty) {
      Messages.showLoadingDialog(context);
      await context.read<ImagesController>().addImage(
            nameController.text,
            imageFile!,
          );

      if (context.mounted) {
        nameController.clear();
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rasm va ismni kiriting")),
      );
    }
  }

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text("Rasm Qo'shish"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Rasm nomi",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Rasm Qo'shish",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: openCamera,
                  label: const Text(
                    "Kamera",
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.camera,
                    size: 18,
                  ),
                ),
                TextButton.icon(
                  onPressed: openGallery,
                  label: const Text(
                    "Galleriya",
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.image,
                    size: 18,
                  ),
                ),
              ],
            ),
            if (imageFile != null)
              SizedBox(
                height: 200,
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              )
          ],
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              FilledButton(
                onPressed: addCar,
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:amaliyot_vazifa/controllers/images_controller.dart';
// import 'package:amaliyot_vazifa/utils/masseges.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class ManageImages extends StatefulWidget {
//   final String? id;
//   final String? name;
//   final String? imageUrl;

//   const ManageImages({super.key, this.id, this.name, this.imageUrl});

//   @override
//   State<ManageImages> createState() => _ManageImagesState();
// }

// class _ManageImagesState extends State<ManageImages> {
//   final nameController = TextEditingController();
//   File? imageFile;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.name != null) {
//       nameController.text = widget.name!;
//     }
//   }

//   Future<void> saveImage() async {
//     Messages.showLoadingDialog(context);
//     if (widget.id != null) {
//       await context.read<ImagesController>().editImage(
//             widget.id!,
//             nameController.text,
//             imageFile,
//           );
//     } else {
//       await context.read<ImagesController>().addImage(
//             nameController.text,
//             imageFile!,
//           );
//     }

//     if (context.mounted) {
//       nameController.clear();
//       Navigator.pop(context);
//       Navigator.pop(context);
//     }
//   }

//   void openGallery() async {
//     final imagePicker = ImagePicker();
//     final XFile? pickedImage = await imagePicker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 100,
//     );
//     if (pickedImage != null) {
//       setState(() {
//         imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         height: 300,
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: "Rasm nomi",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 imageFile != null
//                     ? Image.file(
//                         imageFile!,
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       )
//                     : widget.imageUrl != null
//                         ? Image.network(
//                             widget.imageUrl!,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           )
//                         : const Icon(
//                             Icons.image,
//                             size: 100,
//                           ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: openGallery,
//                   child: const Text("Galereya"),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: saveImage,
//               child: Text(widget.id != null ? "O'zgartirish" : "Saqlash"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
