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
  @override
  Widget build(BuildContext context) {
    
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
      markerId: const MarkerId('localizacion'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.location_searching),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;

              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50,
                  )));
            },
          )
        ],
      ),
      body: GoogleMap(
        mapType: currentMapType,
        markers: markers,
        initialCameraPosition: _puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton:
       Padding(
         padding: const EdgeInsets.only(right: 0.0,bottom: 5.0),
         child: FloatingActionButton(
          child: const Icon(Icons.layers),
          backgroundColor: Colors.white.withValues(alpha: 0.7),
          foregroundColor: Colors.black,         
          onPressed: (){
            setState(() {
              if(currentMapType==MapType.normal){
                currentMapType = MapType.hybrid;
              } else{
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
