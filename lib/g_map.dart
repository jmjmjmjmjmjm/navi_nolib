import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/example_model.dart';

class GMap extends StatefulWidget {
  ContentModel model;

  GMap({Key? key, required this.model}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  List<Marker> _markers = [];

  Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(widget.model.place['lat'], widget.model.place['lng']),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
        markerId: MarkerId(''),
        draggable: false,
        position:
            LatLng(widget.model.place['lat'], widget.model.place['lng'])));
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      height: 100,
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: false,
          compassEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          markers: Set.from(_markers),
          myLocationButtonEnabled: false,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
