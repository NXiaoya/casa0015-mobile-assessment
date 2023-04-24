import 'package:cloud_firestore/cloud_firestore.dart';

class userProfile {
  final String name;
  final String location;
  final String contact;

  userProfile(
      {required this.name, required this.location, required this.contact});
}
