import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

extension strs on String{
  Color get col => HexColor.fromHex(this[0] == "#" ? "${this}" : "#$this");

  Future<Uint8List> fgetBytesFromAsset( int width) async {
    ByteData data = await rootBundle.load(this);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  bool isNullOrEmpty() =>
      this == null || this?.toLowerCase() == "null" || this?.trim() == "";
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String? hexString) {
    if (hexString?.isEmpty==true) {
      return Colors.transparent;
    }
    final buffer = StringBuffer();
    if (hexString == null || hexString.isNullOrEmpty() || hexString.length < 4) {
      return Colors.black;
    }
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.tryParse(buffer.toString() , radix: 16) ?? 0);
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

