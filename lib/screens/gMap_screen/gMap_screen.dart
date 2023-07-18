import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GMapScreen extends StatefulWidget {
  const GMapScreen({Key? key,
    required this.sourcePosition,
    required this.destinationPosition,}) : super(key: key);

  final LatLng sourcePosition;
  final LatLng destinationPosition;

  @override
  State<GMapScreen> createState() => _GMapScreenState();
}

class _GMapScreenState extends State<GMapScreen> {

  LatLng? sourceLatLng;
  LatLng? destinationLatLng;
  String? currentAddress;
  bool isSearchBarOpen = false;
  bool isSearchopen = false;
  LatLng? valueFromSearchBarLatLng = null;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  @override
  void initState() {
    sourceLatLng = widget.sourcePosition;
    destinationLatLng = widget.destinationPosition;
    getPolyLines();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyLines() async {
    polylineCoordinates = [];
    final PolylinePoints polylinePoints = PolylinePoints();
    final PolylineResult result =
    await polylinePoints.getRouteBetweenCoordinates(
        'API_KEY',
        PointLatLng(sourceLatLng!.latitude, sourceLatLng!.longitude),
        PointLatLng(
            destinationLatLng!.latitude, destinationLatLng!.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }


  Future<void> moveMapCamera(LatLng newSrc,double zoomLevel) async {
    // CameraPosition nepPos = CameraPosition(
    //   target: newSrc,
    //   zoom: 14,
    // );
    //
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(nepPos));
    // setState(() {
    //
    // });
    mapController = await _controller.future;
    print(newSrc);
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newSrc,
          zoom: zoomLevel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold
          (body: getMapWidget()
        )
    );
  }

  Widget getMapWidget(){
    return Container(
      margin: const EdgeInsets.all(50),
      //height: height * (1 - 0.6),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: sourceLatLng!,
              //25.617634262060246, 85.14459617757733
              zoom: 4),
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.lightBlue,
              width: 4,
            ),
          },
          onMapCreated: (controller) async {
            // _controller.complete(controller);
            // if (!_controller.isCompleted) {
            //   _controller.complete(controller);
            //   //mapController = controller;
            // }
            if (!_controller.isCompleted) {
              _controller.complete(controller);
              mapController = await _controller.future;
            } else {
              mapController = controller;
            }
          },
          markers: {
            Marker(
                markerId: MarkerId("source"),
                position: sourceLatLng!,
                icon: BitmapDescriptor
                    .defaultMarkerWithHue(
                    BitmapDescriptor.hueRed)),
            Marker(
                markerId: MarkerId("destination"),
                position: destinationLatLng!,
                icon: BitmapDescriptor
                    .defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen))
          },
          zoomControlsEnabled: false,
        ),
      ),
    );
  }
}
