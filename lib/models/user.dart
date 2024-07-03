import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  String name;
  String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory User.fromQuerySnapshot(QueryDocumentSnapshot query) {
    return User(
      id: query.id,
      name: query['name'],
      imageUrl: query['imageUrl'],
    );
  }
}
