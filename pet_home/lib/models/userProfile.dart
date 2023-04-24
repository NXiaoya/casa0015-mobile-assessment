import 'package:cloud_firestore/cloud_firestore.dart';

class userProfile {
  final String name;
  final String contact;
  final String location;


  userProfile(
      {required this.name,required this.contact, required this.location});
}
