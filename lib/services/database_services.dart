// import '../models/dart/userdata.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseService {
//
//   final String uid;
//   DatabaseService({ required this.uid });
//
//   // collection reference
//   final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
//
//   Future<void> updateUserData(String sugars, String name, int strength) async {
//     return await brewCollection.doc(uid).add({
//       'sugars': sugars,
//       'name': name,
//       'strength': strength,
//     });
//   }
//
//   // brew list from snapshot
//   List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.documents.map((doc){
//       //print(doc.data);
//       return Brew(
//           name: doc.data['name'] ?? '',
//           strength: doc.data['strength'] ?? 0,
//           sugars: doc.data['sugars'] ?? '0'
//       );
//     }).toList();
//   }
//
//   // get brews stream
//   Stream<List<Brew>> get brews {
//     return brewCollection.snapshots()
//         .map(_brewListFromSnapshot);
//   }
//
// }