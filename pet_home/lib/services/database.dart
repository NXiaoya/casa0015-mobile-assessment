import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // collection reference
  final CollectionReference profileCollection = FirebaseFirestore.instance.collection('profile');

}