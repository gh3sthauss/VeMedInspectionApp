import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Central mapping from a modality label to its SVG icon asset.
///
/// The View (Documents) and Create (Create Report) pages both render modality
/// tiles, so keeping the label→asset lookup here means an icon swap is a
/// one-line change that both pages pick up automatically.
///
/// A few modalities have no exact artwork in the icon set and use the closest
/// available match: X-Ray → Mobile, CR → the combined PACS/DR icon.
const String _iconDir = 'assets/images/modality_icons';

const Map<String, String> _modalityIconAssets = {
  'Angiography': '$_iconDir/angiography.svg',
  'CT': '$_iconDir/ct.svg',
  'Ultrasound': '$_iconDir/ultrasound.svg',
  'MRI': '$_iconDir/mri.svg',
  'X-Ray': '$_iconDir/xray.svg',
  'Fluoroscopy': '$_iconDir/fluoroscopy.svg',
  'C-Arm': '$_iconDir/c_arm.svg',
  'Mammography': '$_iconDir/mammography.svg',
  'PACS': '$_iconDir/pacs.svg',
  'DR': '$_iconDir/dr.svg',
  'CR': '$_iconDir/cr.svg',
};

/// The SVG asset path for [label], falling back to the generic "Others" icon
/// when a modality isn't in the map.
String modalityIconAsset(String label) =>
    _modalityIconAssets[label] ?? '$_iconDir/others.svg';

/// A modality icon rendered at [size]. Uses the shared mapping above.
class ModalityIcon extends StatelessWidget {
  const ModalityIcon({
    super.key,
    required this.label,
    this.size = 48.0,
  });

  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      modalityIconAsset(label),
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
