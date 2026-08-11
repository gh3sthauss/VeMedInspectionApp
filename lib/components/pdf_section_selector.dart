import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// One selectable section of a report PDF. [key] is the stable identifier the
/// export function gates on; [label] is what the user sees.
class PdfSection {
  const PdfSection(this.key, this.label);
  final String key;
  final String label;
}

/// Sections of the Angiography report, in the order they appear in the PDF.
/// The cover page is always included and is intentionally not listed here.
const List<PdfSection> kAngiographyPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('tube', 'Tube Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('software', 'Software Information'),
  PdfSection('console', 'Console and Workstation(s) Information'),
  PdfSection('patient_table', 'Patient Table Information'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('phantoms', 'Phantoms'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kCtPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('gantry', 'Gantry'),
  PdfSection('cooling_system', 'Cooling System'),
  PdfSection('patient_table', 'Patient Table Information'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kMriPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('magnet', 'Magnet'),
  PdfSection('cooler_compressor', 'Cooler / Compressor'),
  PdfSection('cold_head', 'Cold Head'),
  PdfSection('imager', 'Imager'),
  PdfSection('ecg', 'ECG'),
  PdfSection('power_stages', 'Power Stages'),
  PdfSection('patient_table', 'Patient Table'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('local_service', 'Local Service'),
  PdfSection('coils', 'Coils'),
  PdfSection('phantoms', 'Phantoms'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kXRayPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('tube', 'Tube Information'),
  PdfSection('table', 'Table Information'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kFluoroscopyPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('tube', 'Tube Information'),
  PdfSection('table', 'Table Information'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kCArmPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('tube', 'Tube Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('software', 'Software Information'),
  PdfSection('phantom', 'Phantom'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kMammographyPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('tube', 'Tube Information'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kPacsPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('cassettes', 'Cassettes'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kDrPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('cassettes', 'Cassettes'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kCrPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('console', 'Console and Workstation Information'),
  PdfSection('detector', 'Detector Information'),
  PdfSection('cassettes', 'Cassettes'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

const List<PdfSection> kUltrasoundPdfSections = [
  PdfSection('system_general', 'System General Information'),
  PdfSection('probes', 'Probes'),
  PdfSection('software', 'Software Information'),
  PdfSection('accessories', 'Accessories'),
  PdfSection('cosmetic', 'Cosmetic Condition'),
  PdfSection('delivery', 'Delivery & Site Access Information'),
  PdfSection('other_notes', 'Other Notes'),
];

/// Shows the "choose which sections to include" sheet before a PDF export.
/// Returns the set of selected section keys, or null if the user cancelled.
/// All sections start checked, matching the full report.
Future<Set<String>?> showPdfSectionSelector(
  BuildContext context, {
  required List<PdfSection> sections,
  String title = 'Choose sections to include',
}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => _PdfSectionSelectorSheet(
      sections: sections,
      title: title,
    ),
  );
}

class _PdfSectionSelectorSheet extends StatefulWidget {
  const _PdfSectionSelectorSheet({required this.sections, required this.title});

  final List<PdfSection> sections;
  final String title;

  @override
  State<_PdfSectionSelectorSheet> createState() =>
      _PdfSectionSelectorSheetState();
}

class _PdfSectionSelectorSheetState extends State<_PdfSectionSelectorSheet> {
  late final Set<String> _selected =
      widget.sections.map((s) => s.key).toSet();

  bool get _allSelected => _selected.length == widget.sections.length;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.0,
                height: 4.0,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: theme.alternate,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.readexPro(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryText,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    if (_allSelected) {
                      _selected.clear();
                    } else {
                      _selected.addAll(widget.sections.map((s) => s.key));
                    }
                  }),
                  child: Text(_allSelected ? 'Deselect all' : 'Select all'),
                ),
              ],
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: widget.sections.map((section) {
                  final checked = _selected.contains(section.key);
                  return CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: theme.primary,
                    value: checked,
                    title: Text(
                      section.label,
                      style: GoogleFonts.readexPro(
                        fontSize: 15.0,
                        color: theme.primaryText,
                      ),
                    ),
                    onChanged: (v) => setState(() {
                      if (v == true) {
                        _selected.add(section.key);
                      } else {
                        _selected.remove(section.key);
                      }
                    }),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: theme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
                onPressed: _selected.isEmpty
                    ? null
                    : () => Navigator.of(context).pop(_selected),
                child: Text(
                  'Generate PDF',
                  style: GoogleFonts.readexPro(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
