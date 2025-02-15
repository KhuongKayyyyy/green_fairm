import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: constant_identifier_names
const String WATER_HISTORY = 'waterHistory';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWaterHistory(String id, Timestamp time) async {
    await _firestore.collection(WATER_HISTORY).add({
      'id': id,
      'time': time,
    });
  }
}
