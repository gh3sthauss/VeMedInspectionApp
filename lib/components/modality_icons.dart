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
  // The Create page uses the app's original spelling "Flouroscopy"; alias it
  // so it resolves to the same icon instead of falling back to Others.
  'Flouroscopy': '$_iconDir/fluoroscopy.svg',
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

/// Soft card gradient that echoes the icons' cyan→indigo ramp in pale tints
/// and along the same top-left→bottom-right axis. This lets the gradient icon
/// fuse into the tile rather than sit on a flat block. Shared by the Create
/// and Documents modality grids so both stay in sync.
const LinearGradient modalityCardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFF3FBFF), Color(0xFFE6ECFF)],
);

/// Rounded, gradient-filled decoration for a modality tile, with a faint
/// indigo drop shadow for a little depth.
BoxDecoration modalityCardDecoration() => BoxDecoration(
      gradient: modalityCardGradient,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x142E54D6),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    );

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
