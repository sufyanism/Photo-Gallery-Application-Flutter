import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:landmark_gallary/models/landmark_model.dart';

class MapViewScreen extends StatelessWidget {
  final Landmark landmark;
  const MapViewScreen({super.key, required this.landmark});

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialposition = CameraPosition(
        target:LatLng(landmark.latitude, landmark.longitude),
      zoom: 14,
    );

    final Marker marker = Marker(
      markerId: MarkerId(landmark.name),
      position: LatLng(landmark.latitude, landmark.longitude),
      infoWindow: InfoWindow(
        title: landmark.name,
        snippet: landmark.location,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Landmark Location'),
        backgroundColor: Colors.deepPurple,
      ),
      body: GoogleMap(
        initialCameraPosition: initialposition,
        markers: {marker},
        zoomControlsEnabled: true,
      ),
    );
  }
}
