import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType currentMapType = MapType.normal;

  Set<Marker> markers = <Marker>{};

  double currentTilt = 0.0;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );
    if (markers.isEmpty) {
      markers.add(Marker(
          markerId: const MarkerId('localizacion-inicial'),
          position: scan.getLatLng(),
          infoWindow: InfoWindow(
            title: 'Localización guardada',
            snippet:
                'Lat : ${scan.getLatLng().latitude} Long : ${scan.getLatLng().longitude}',
          )));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Volver a la localizacion inicial',
            icon: const Icon(Icons.location_searching),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;

              controller
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: scan.getLatLng(),
                zoom: 17,
                tilt: 50,
              )));
            },
          ),
          IconButton(
              tooltip: 'Borrar todos los marcadores',
              onPressed: () {
                setState(() {
                  markers.clear();
                });
              },
              icon: const Icon(Icons.delete_sweep)),
          IconButton(
              tooltip: 'Cambiar inclinacion',
              onPressed: () async {
                if (currentTilt == 0.0) {
                  currentTilt = 45.0;
                } else if (currentTilt == 45.0) {
                  currentTilt = 75.0;
                } else {
                  currentTilt = 0.0;
                }
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: scan
                      .getLatLng(), 
                  tilt: currentTilt,
                  zoom: 17,
                )));

                setState(() {});
              },
              icon: const Icon(Icons.threed_rotation))
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: currentMapType,
        markers: markers,
        initialCameraPosition: _puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (LatLng posicionClickada) => setState(() {
          markers.add(Marker(
            markerId: MarkerId('localizacion : ${posicionClickada.toString()}'),
            position: posicionClickada,
            infoWindow: InfoWindow(
              title: 'Ubicación seleccionada',
              snippet:
                  'Lat : ${posicionClickada.latitude} Long : ${posicionClickada.longitude}',
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ));
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 0.0, bottom: 5.0),
        child: FloatingActionButton(
          child: const Icon(Icons.layers),
          backgroundColor: Colors.white.withValues(alpha: 0.7),
          foregroundColor: Colors.black,
          onPressed: () {
            setState(() {
              if (currentMapType == MapType.normal) {
                currentMapType = MapType.hybrid;
              } else {
                currentMapType = MapType.normal;
              }
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
