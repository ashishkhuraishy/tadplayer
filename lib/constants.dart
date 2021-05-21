import 'dart:typed_data';

import 'package:flutter/services.dart';

var kPlaceHolder = Uint8List(10000);

Future<void> loadPlaceholder() async {
  final byteData = await rootBundle.load('assets/black_placeholder.jpeg');

  kPlaceHolder = byteData.buffer.asUint8List(
    byteData.offsetInBytes,
    byteData.lengthInBytes,
  );
}
