import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../main.dart'; 

// --- 1. LOCAL CLASS DEFINITION ---
class AadhaarCenter {
  final String id;
  final String name;
  final LatLng location;
  final int stressScore;

  AadhaarCenter({
    required this.id,
    required this.name,
    required this.location,
    required this.stressScore,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  
  // --- 2. UNIFIED LIST OF CENTRES ---
  final List<AadhaarCenter> _allRaipurCenters = [
    AadhaarCenter(
      id: "1", 
      name: "ASK Pandri (Shyam Plaza)", 
      location: const LatLng(21.2539, 81.6521), 
      stressScore: 88
    ),
    AadhaarCenter(
      id: "2", 
      name: "GPO Raipur (Jaistambh)", 
      location: const LatLng(21.2461, 81.6310), 
      stressScore: 35
    ),
    AadhaarCenter(
      id: "101", 
      name: "ASK Pachpedi Naka", 
      location: const LatLng(21.2185, 81.6521), 
      stressScore: 42
    ),
    AadhaarCenter(
      id: "102", 
      name: "Aadhaar Seva Kendra, Civil Lines", 
      location: const LatLng(21.2384, 81.6461), 
      stressScore: 91
    ),
    AadhaarCenter(
      id: "103", 
      name: "Post Office, Tatibandh", 
      location: const LatLng(21.2635, 81.5688), 
      stressScore: 15
    ),
  ];

  late AadhaarCenter _selectedCenter;

  @override
  void initState() {
    super.initState();
    _selectedCenter = _allRaipurCenters[0];
  }

  void _updateCameraPosition(LatLng position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // THE MAP
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _selectedCenter.location,
              zoom: 14
            ),
            padding: const EdgeInsets.only(bottom: 240),
            zoomControlsEnabled: true,
            markers: {
              Marker(
                markerId: MarkerId(_selectedCenter.id),
                position: _selectedCenter.location,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  _selectedCenter.stressScore > 75 
                      ? BitmapDescriptor.hueRed 
                      : BitmapDescriptor.hueAzure
                ),
                infoWindow: InfoWindow(
                  title: _selectedCenter.name,
                  snippet: "Stress Score: ${_selectedCenter.stressScore}%",
                ),
              ),
            },
          ),

          // BOTTOM UI
          Positioned(
            bottom: 30, left: 15, right: 15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStressAlert(),
                const SizedBox(height: 10),
                _buildSelectionCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(25), 
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 15)]
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFF0D47A1)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedCenter.name, 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                    ),
                    const Text("Select Aadhaar Center / केंद्र चुनें", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          
          DropdownButton<AadhaarCenter>(
            value: _selectedCenter,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Color(0xFF0D47A1)),
            items: _allRaipurCenters.map((center) {
              return DropdownMenuItem(
                value: center,
                child: Text(center.name),
              );
            }).toList(),
            onChanged: (AadhaarCenter? val) {
              if (val != null) {
                setState(() {
                  _selectedCenter = val;
                  _updateCameraPosition(val.location);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStressAlert() {
    int score = _selectedCenter.stressScore;
    Color stressColor = score > 75 ? Colors.red : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(color: stressColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.sensors, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Center Status: $score% Load | केंद्र लोड: $score%", 
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)
            )
          ),
          IconButton(
            icon: const Icon(Icons.analytics_outlined, color: Colors.white, size: 20), 
            onPressed: () => homeTabIndex.value = 1 
          )
        ],
      ),
    );
  }
}
