// // ignore_for_file: depend_on_referenced_packages

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:solutionchallenge2024/models/coordonnees.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'widgets/text.dart';
// import 'package:location/location.dart';

// class MapSample extends StatefulWidget {
//   const MapSample({super.key, required this.coordonneeModel});
//   final CoordonneeModel coordonneeModel;

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   Location locationController = Location();
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   final Map<String, dynamic> coordIn = {
//     'latitude': -2.500933,
//     'longitude': 28.871922,
//     'altitude': 0
//   };

//   LatLng? _currentP;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Builder(builder: (context) {
//         return GoogleMap(
//           myLocationButtonEnabled: true,
//           markers: {
//             const Marker(
//               markerId: MarkerId("_currentLocation"),
//               icon: BitmapDescriptor.defaultMarker,
//               position: LatLng(37.785834, -122.406417),
//             ),
//             const Marker(
//               markerId: MarkerId("_sourceLocation"),
//               icon: BitmapDescriptor.defaultMarker,
//               position: LatLng(37.795833, -122.406413),
//             ),
//             const Marker(
//               markerId: MarkerId("destina"),
//               icon: BitmapDescriptor.defaultMarker,
//               position: LatLng(37.795833, -122.406413),
//             ),
//           },
//           mapType: MapType.hybrid,
//           initialCameraPosition: const CameraPosition(
//             target: LatLng(37.785834, -122.406417),
//             zoom: 14.4746,
//           ),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         );
//       }),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const TextSmall('Aller'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//           bearing: 192.8334901395799,
//           target: LatLng(widget.coordonneeModel.latitude,
//               widget.coordonneeModel.longitude),
//           tilt: 59.440717697143555,
//           zoom: 19.151926040649414),
//     ));
//   }
// }

// Future<void> geoLocationUpdated() async {
//   bool serviceEnabled;
//   PermissionStatus permiss;
//   serviceEnabled = await location.serviceEnabled();
//   if (serviceEnabled) {
//     serviceEnabled = await location.requestService();
//   } else {
//     return;
//   }

//   permiss = await location.hasPermission();
//   if (permiss == PermissionStatus.denied) {
//     permiss = await location.requestPermission();
//     if (permiss != PermissionStatus.granted) {
//       return;
//     }
//   }
//   location.onLocationChanged.listen((LocationData currentLocation) {
//     if (currentLocation.latitude != null && currentLocation.longitude != null) {
//       _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
//     }
//   });
// }

// Future<List<LatLng>> getPolylinesPoints() async {
//   List<LatLng> polyLineCordinated = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   PolylineResult polylineResult =
//       await polylinePoints.getRouteBetweenCoordinates(
//           "AIzaSyC7t0jfPIZD-T1J-OJOkLVoV7UxuHww0S8",
//           const PointLatLng(37.795833, -122.406413),
//           const PointLatLng(37.795833, -122.406413),
//           travelMode: TravelMode.driving);
//   if (polylineResult.points.isNotEmpty) {
//     for (var point in polylineResult.points) {
//       polyLineCordinated.add(LatLng(point.latitude, point.longitude));
//     }
//   } else {}
//   return polyLineCordinated;
// }
