import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// A full-screen camera that lets the user take several photos in one session
/// and confirm them all at once. Unlike image_picker's camera (which forces a
/// "Retake / Use Photo" step after every single shot), the shutter here keeps
/// the preview live: tap it as many times as you like, watch each shot stack in
/// the strip at the bottom, then tap "Done" once to add them all.
///
/// Pops with the captured photos as a `List<XFile>` (newest last), or `null`
/// if the user backs out without keeping anything.
class MultiCaptureCameraPage extends StatefulWidget {
  const MultiCaptureCameraPage({super.key});

  @override
  State<MultiCaptureCameraPage> createState() => _MultiCaptureCameraPageState();
}

class _MultiCaptureCameraPageState extends State<MultiCaptureCameraPage>
    with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initFuture;
  final List<XFile> _shots = [];
  bool _capturing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setUpCamera();
  }

  Future<void> _setUpCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _error = 'No camera available on this device.');
        return;
      }
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        back,
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );
      _controller = controller;
      _initFuture = controller.initialize();
      await _initFuture;
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) setState(() => _error = 'Could not start the camera.');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    // Free the camera when the app is backgrounded, re-acquire it on resume.
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      controller.dispose();
      _controller = null;
    } else if (state == AppLifecycleState.resumed) {
      _setUpCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takeShot() async {
    final controller = _controller;
    if (controller == null ||
        !controller.value.isInitialized ||
        _capturing ||
        controller.value.isTakingPicture) {
      return;
    }
    setState(() => _capturing = true);
    try {
      final shot = await controller.takePicture();
      if (mounted) setState(() => _shots.add(shot));
    } catch (_) {
      // Ignore a single failed capture; the preview stays up for a retry.
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  void _removeShot(int index) {
    setState(() => _shots.removeAt(index));
  }

  void _done() => Navigator.of(context).pop<List<XFile>>(_shots);

  Future<void> _cancel() async {
    if (_shots.isEmpty) {
      Navigator.of(context).pop();
      return;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard photos?'),
        content: Text(
            'You have ${_shots.length} photo${_shots.length == 1 ? '' : 's'} '
            'that haven\'t been added yet.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep taking'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    if (discard == true && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final ready = controller != null &&
        controller.value.isInitialized &&
        _error == null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _cancel();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Live preview (or an error / loading state).
              Positioned.fill(
                child: _error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : ready
                        ? Center(child: CameraPreview(controller))
                        : const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
              ),

              // Close button, top-left.
              Positioned(
                top: 8,
                left: 8,
                child: _roundButton(
                  icon: Icons.close,
                  onTap: _cancel,
                ),
              ),

              // Bottom bar: captured strip + shutter + done.
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_shots.isNotEmpty) _capturedStrip(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Spacer so the shutter stays centred.
                          const SizedBox(width: 72),
                          Expanded(
                            child: Center(
                              child: _shutterButton(ready),
                            ),
                          ),
                          SizedBox(
                            width: 72,
                            child: _shots.isEmpty
                                ? null
                                : TextButton(
                                    onPressed: _done,
                                    child: Text(
                                      'Done (${_shots.length})',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _capturedStrip() {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _shots.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(
                  File(_shots[i].path),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -6,
                right: -6,
                child: GestureDetector(
                  onTap: () => _removeShot(i),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(Icons.close,
                        color: Colors.white, size: 14),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _shutterButton(bool ready) {
    return GestureDetector(
      onTap: ready ? _takeShot : null,
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: ready ? 1.0 : 0.4),
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: _capturing
            ? const Padding(
                padding: EdgeInsets.all(18.0),
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : null,
      ),
    );
  }

  Widget _roundButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }
}
