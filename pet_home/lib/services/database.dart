
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_home/models/userProfile.dart';
import 'package:pet_home/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({ this.uid = '' });

  // collection reference
  final CollectionReference profileCollection = FirebaseFirestore.instance
      .collection('profile');


  Future updateUserData(String name, String location, String contact) async {
    return await profileCollection.doc(uid).set({
      'name': name,
      'contact': contact,
      'location': location,
    });
  }

  // profile list from snapshot
  List<userProfile> _userProfileListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return userProfile(
        name: doc.get('name') ?? '',
        location: doc.get('contact') ?? '',
        contact: doc.get('location') ?? '',
      );
    }).toList();
  }
  // user data from snapshots
  UserData _UserDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        contact: snapshot.get('contact'),
        location: snapshot.get('location'),

    );
  }
  // get brews stream
  Stream<List<userProfile>> get profile {
    return profileCollection.snapshots()
        .map(_userProfileListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return profileCollection.doc(uid).snapshots()
        .map(_UserDataFromSnapshot);
  }

}




