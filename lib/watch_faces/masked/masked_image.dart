import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MaskedImage extends StatelessWidget {
  final ImageProvider image;
  final Widget child;

  const MaskedImage({super.key, required this.image, required this.child});

  @override
  Widget build(BuildContext context) => FutureBuilder<ui.Image>(
      future: loadImage(),
      builder: (context, snap) => snap.hasData
          ? ShaderMask(
              // blendMode: BlendMode.dstATop,
              shaderCallback: (bounds) => ImageShader(snap.data!,
                  TileMode.clamp, TileMode.clamp, Matrix4.identity().storage),
              child: child,
            )
          : Container());

  Future<ui.Image> loadImage() async {
    final completer = Completer<ui.Image>();
    final stream =
        image.resolve(const ImageConfiguration(size: Size(540, 540)));
    stream.addListener(
        ImageStreamListener((info, _) => completer.complete(info.image)));

    return completer.future;
  }
}
