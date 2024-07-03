import 'package:amaliyot_vazifa/views/widgets/images_list_widgets.dart';
import 'package:amaliyot_vazifa/views/widgets/manage_images.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Students',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return const ManageImages();
                },
              );
            },
            icon: const Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: const ImagesList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 80,
        width: double.infinity,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Firebase',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Duo',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Costum Paint',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
