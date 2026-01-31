import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/center_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream to get real-time center data (e.g., for Raipur)
  Stream<List<AadhaarCenter>> getRaipurCenters() {
    return _db.collection('aadhaar_centers').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) {
          final data = doc.data();
          return AadhaarCenter(
            id: doc.id,
            name: data['name'],
            stressScore: data['stressScore'] ?? 0,
            issues: data['issues'] ?? "Clear",
            location: LatLng(data['lat'], data['lng']),
            prediction: data['prediction'] ?? "Stable",
          );
        }).toList());
  }
}
