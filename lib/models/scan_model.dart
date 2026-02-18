import 'dart:convert';

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
