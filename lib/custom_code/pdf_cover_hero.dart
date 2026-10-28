// The device photo on a PDF cover. The box is always the same full-width
// shape; the photo is shown whole (never cropped) and the space it leaves
// on the sides is filled with a soft, blurred copy of the same photo.

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const double kCoverHeroHeight = 360;

final Expando<pw.ImageProvider> _backdrops = Expando();

Uint8List? _blurredBackdrop(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;
  // Small is plenty for a blur, and keeps the PDF light.
  var small = img.bakeOrientation(decoded);
  small = img.copyResize(small, width: small.width >= small.height ? 600 : 400);
  small = img.gaussianBlur(small, radius: 24);
  // Wash it out towards white so the sharp photo stands out.
  small = img.adjustColor(small, brightness: 1.25, saturation: 0.6);
  return Uint8List.fromList(img.encodeJpg(small, quality: 70));
}

/// Builds the blurred backdrop for [hero] ahead of time (decoding is
/// async/off the UI thread; the PDF widget tree is built synchronously).
Future<void> prepareCoverHero(pw.ImageProvider? hero) async {
  if (hero is! pw.MemoryImage || _backdrops[hero] != null) return;
  try {
    final bytes = await compute(_blurredBackdrop, hero.bytes);
    if (bytes != null) _backdrops[hero] = pw.MemoryImage(bytes);
  } catch (_) {}
}

pw.Widget coverHeroBox(pw.ImageProvider hero, {required PdfColor borderColor}) {
  final backdrop = _backdrops[hero];
  return pw.Container(
    width: double.infinity,
    height: kCoverHeroHeight,
    decoration: pw.BoxDecoration(
      color: PdfColor.fromInt(0xFFF3F4F6),
      border: pw.Border.all(color: borderColor, width: 1),
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
    ),
    child: pw.ClipRRect(
      horizontalRadius: 6,
      verticalRadius: 6,
      child: pw.Stack(
        fit: pw.StackFit.expand,
        children: [
          if (backdrop != null) pw.Image(backdrop, fit: pw.BoxFit.cover),
          pw.Center(child: pw.Image(hero, fit: pw.BoxFit.contain)),
        ],
      ),
    ),
  );
}
