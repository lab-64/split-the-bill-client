import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';

class ImageUtils {
  static Future<ui.Image> createImageFromFile(String path) async {
    Uint8List byteList = await File(path).readAsBytes();
    ui.Codec codec = await ui.instantiateImageCodec(byteList);
    return (await codec.getNextFrame()).image;
  }
}
