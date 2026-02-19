import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final _url = scan.valor;
  if (scan.tipos == 'http') {
    if (await launch(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  else {
      Navigator.pushNamed(context, 'mapa', arguments: scan);
    }
}
