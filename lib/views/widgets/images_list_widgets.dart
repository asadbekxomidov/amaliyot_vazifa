// import 'package:amaliyot_vazifa/controllers/images_controller.dart';
// import 'package:amaliyot_vazifa/models/user.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ImagesList extends StatelessWidget {
//   const ImagesList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final imagesController = context.watch<ImagesController>();

//     return StreamBuilder(
//       stream: imagesController.list,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(
//             child: Text("Rasm mavjud emas"),
//           );
//         }
//         final images = snapshot.data!.docs;
//         return ListView.builder(
//           padding: const EdgeInsets.all(20.0),
//           itemCount: images.length,
//           itemBuilder: (ctx, index) {
//             final image = User.fromQuerySnapshot(images[index]);
//             return ListTile(
//               tileColor: Colors.grey.shade50,
//               leading: Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(
//                       image.imageUrl,
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(100),
//                   color: Colors.grey.shade50,
//                 ),
//               ),
//               title: Text(
//                 image.name,
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               onTap: () {},
//               trailing: Expanded(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.edit,
//                         size: 25,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.delete,
//                         size: 25,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:amaliyot_vazifa/controllers/images_controller.dart';
import 'package:amaliyot_vazifa/models/user.dart';
import 'package:amaliyot_vazifa/views/widgets/manage_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({super.key});

  @override
  Widget build(BuildContext context) {
    final imagesController = context.read<ImagesController>();

    return StreamBuilder(
      stream: imagesController.list,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text("Rasm mavjud emas"),
          );
        }
        final images = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(20.0),
          itemCount: images.length,
          itemBuilder: (ctx, index) {
            final image = User.fromQuerySnapshot(images[index]);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        image.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                title: Text(
                  image.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return ManageImages(
                                // id: image.id,
                                // name: image.name,
                                // imageUrl: image.imageUrl,
                                );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await imagesController.deleteImage(image.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
