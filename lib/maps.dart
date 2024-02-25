// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:solutionchallenge2024/widgets/not_found.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class ViewMaps extends StatefulWidget {
  const ViewMaps({
    super.key,
    this.posPost,
    this.isAdd = true,
    required this.latitude,
    required this.longitude,
  });
  final LatLng? posPost;
  final double latitude;
  final double longitude;
  final bool isAdd;
  @override
  State<ViewMaps> createState() => _ViewMapsState();
}

class _ViewMapsState extends State<ViewMaps> {
  final Location _locationController = Location();

  LatLng? _currentP;
  LatLng? _currentPFirst;
  late StreamSubscription streamSubscription;

  Map<PolylineId, Polyline> polylines = {};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    geoLocationUpdated().then((_) => {
          if (_currentP != null)
            {
              getPolylinesPoints().then(
                (coordonnees) {
                  print('List<LatLng> $coordonnees');
                  generatePolyneFromPoint(coordonnees);
                },
              )
            }
        });

    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _currentP == null
        ? const LoadingWidget()
        : widget.isAdd
            ? GoogleMap(
                myLocationButtonEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId("_currentLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: widget.posPost!,
                  ),
                },
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: widget.posPost!,
                  zoom: 14.4746,
                ),
              )
            : GoogleMap(
                myLocationButtonEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId("_currentLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentP!,
                  ),
                  Marker(
                    markerId: const MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentPFirst!,
                  ),
                  Marker(
                    markerId: const MarkerId("_destinationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: widget.posPost!,
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                polylines: Set<Polyline>.of(polylines.values),
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: widget.posPost!,
                  zoom: 14.4746,
                ),
              );
  }

  Future<void> geoLocationUpdated() async {
    bool serviceEnabled;
    PermissionStatus permiss;
    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    // if (serviceEnabled) {
    // serviceEnabled = await _locationController.requestService();
    // } else {
    // return;
    // }

    permiss = await _locationController.hasPermission();
    if (permiss == PermissionStatus.denied) {
      permiss = await _locationController.requestPermission();
      if (permiss != PermissionStatus.granted) {
        return;
      }
    }
    streamSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _currentPFirst ??= _currentP;
        });
      }
    });
  }

  Future<void> goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          bearing: 192.8334901395799,
          target: widget.posPost!,
          tilt: 59.440717697143555,
          zoom: 19.151926040649414),
    ));
  }

  Future<List<LatLng>> getPolylinesPoints() async {
    List<LatLng> polyLineCordinated = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
            "AIzaSyC7t0jfPIZD-T1J-OJOkLVoV7UxuHww0S8",
            PointLatLng(_currentP!.latitude, _currentP!.longitude),
            PointLatLng(widget.latitude, widget.longitude),
            travelMode: TravelMode.driving);
    if (polylineResult.points.isNotEmpty) {
      for (var point in polylineResult.points) {
        polyLineCordinated.add(LatLng(point.latitude, point.longitude));
      }
    } else {}
    return polyLineCordinated;
  }

  void generatePolyneFromPoint(List<LatLng> polylinesCoordonates) async {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylinesCoordonates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
