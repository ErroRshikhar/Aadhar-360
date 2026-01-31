import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/center_model.dart';

final List<AadhaarCenter> raipurCenters = [
  AadhaarCenter(
    id: "1",
    name: "ASK Pandri (Shyam Plaza)",
    stressScore: 85,
    issues: "Server Lag: Biometric slow",
    location: const LatLng(21.2539, 81.6521),
    prediction: "High Failure (80%)",
  ),
  AadhaarCenter(
    id: "2",
    name: "GPO Raipur (Jaistambh)",
    stressScore: 25,
    location: const LatLng(21.2415, 81.6334),
  ),
];
