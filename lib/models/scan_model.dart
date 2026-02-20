import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
    int? id;
    String? tipos;
    String valor;

    ScanModel({
         this.id,
         this.tipos,
        required this.valor,
        
    }){
      if(this.valor.contains('http')){
        this.tipos= 'http';
      }
        else{
          this.tipos='geo';
      }
    }

    LatLng getLatLng() {
      final latlng = this.valor.substring(4).split(',');
      final latitude = double.parse(latlng[0]);
      final longitude = double.parse(latlng[1]);

      return LatLng(latitude,longitude);
    }

    factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipos: json["tipos"],
        valor: json["valor"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "tipos": tipos,
        "valor": valor,
    };
}
