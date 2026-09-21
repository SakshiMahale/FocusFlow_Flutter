import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Experiment4Screen extends StatefulWidget {
  const Experiment4Screen({super.key});

  @override
  State<Experiment4Screen> createState() => _Experiment4ScreenState();
}

class _Experiment4ScreenState extends State<Experiment4Screen> {
  GoogleMapController? _mapController;

  bool _locationPermissionGranted = false;

  Position? _currentPosition;

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('marker1'),
      position: const LatLng(19.0760, 72.8777),
      infoWindow: const InfoWindow(
        title: 'Mumbai',
        snippet: 'Sample location marker',
      ),
    ),
    Marker(
      markerId: const MarkerId('marker2'),
      position: const LatLng(19.0330, 73.0297),
      infoWindow: const InfoWindow(
        title: 'Sample Place',
        snippet: 'Another marker',
      ),
    ),
  };

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(19.0760, 72.8777),
    zoom: 12,
  );

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enable location services.')),
      );

      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission was denied.')),
      );

      return;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    setState(() {
      _currentPosition = position;
      _locationPermissionGranted = true;

      _markers.removeWhere(
        (marker) => marker.markerId.value == 'currentLocation',
      );

      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'You are here'),
        ),
      );
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 - Google Maps')),

      body: GoogleMap(
        initialCameraPosition: _initialPosition,

        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },

        markers: _markers,

        myLocationEnabled: _locationPermissionGranted,

        myLocationButtonEnabled: false,

        zoomControlsEnabled: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getCurrentLocation,
        icon: const Icon(Icons.my_location),
        label: const Text('My Location'),
      ),
    );
  }
}
