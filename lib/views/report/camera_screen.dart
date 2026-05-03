import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:jalan_in/views/notifications/notifications_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:jalan_in/providers/report_provider.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final Color primaryRed = const Color(0xFF8A0B14);
  final Color bgPink = const Color(0xFFFEF9F9);
  final Color formBg = const Color(0xFFFFF2F1); // Pink sangat muda sesuai mockup

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  Position? _currentPosition;
  String? _capturedImagePath;
  final TextEditingController _descController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    if (mounted) setState(() => _currentPosition = position);
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(_cameras![0], ResolutionPreset.medium, enableAudio: false);
      await _cameraController!.initialize();
      if (mounted) setState(() => _isCameraInitialized = true);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPink,
      appBar: AppBar(
        backgroundColor: bgPink,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: primaryRed),
          onPressed: () {},
        ),
        title: Text(
          'jalan.in',
          style: TextStyle(
            color: primaryRed,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: primaryRed),
            onPressed: () => showNotificationsPopup(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 2),
        children: [
          // 1. AREA KAMERA (Sesuai Desain)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 420,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.14),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Preview Kamera
                    _capturedImagePath != null
                      ? SizedBox.expand(child: Image.file(File(_capturedImagePath!), fit: BoxFit.cover))
                      : (_isCameraInitialized 
                        ? SizedBox.expand(child: CameraPreview(_cameraController!)) 
                        : Container(color: Colors.black)),

                    // Overlay Scanner Frame
                    Center(
                      child: Container(
                        width: 180, height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    // Badge GPS Aktif
                    Positioned(
                      top: 16, left: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              _currentPosition != null ? 'GPS AKTIF: ${_currentPosition!.latitude.toStringAsFixed(4)}° N' : 'MENCARI GPS...', 
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Tombol Flash atau Close Image
                    Positioned(
                      top: 16, right: 16,
                      child: _capturedImagePath != null
                        ? GestureDetector(
                            onTap: () => setState(() => _capturedImagePath = null),
                            child: _buildCircleBtn(Icons.close),
                          )
                        : _buildCircleBtn(Icons.flash_on_outlined),
                    ),

                    // Tombol Kontrol Bawah
                    Positioned(
                      bottom: 20, left: 0, right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSquareBtn(Icons.photo_library_outlined),
                          // Shutter
                          GestureDetector(
                            onTap: () async {
                              if (_cameraController != null && _cameraController!.value.isInitialized && _capturedImagePath == null) {
                                final XFile file = await _cameraController!.takePicture();
                                setState(() => _capturedImagePath = file.path);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4)),
                              child: const CircleAvatar(radius: 28, backgroundColor: Colors.white),
                            ),
                          ),
                          _buildSquareBtn(Icons.cameraswitch_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. AREA FORM (Latar Pink)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            decoration: BoxDecoration(
              color: formBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('DESKRIPSI'),
                TextField(
                  controller: _descController,
                  maxLines: 4,
                  decoration: _inputDeco('Deskripsikan tingkat keparahan dan catatan lokasi spesifik...'),
                ),
                SizedBox(height: 16),
                _label('TITIK LOKASI'),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: primaryRed.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.location_searching, color: primaryRed, size: 20),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('TITIK LOKASI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                          Text(
                            _currentPosition != null 
                              ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}' 
                              : 'Mencari lokasi...', 
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : () async {
                      if (_capturedImagePath == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Silakan ambil foto terlebih dahulu')));
                        return;
                      }
                      if (_currentPosition == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lokasi belum ditemukan')));
                        return;
                      }
                      setState(() => _isSubmitting = true);
                      try {
                        final provider = Provider.of<ReportProvider>(context, listen: false);
                        bool success = await provider.createReport(
                          _descController.text,
                          _capturedImagePath!,
                          _currentPosition!.latitude,
                          _currentPosition!.longitude
                        );
                        if (success && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Laporan berhasil dikirim!')));
                          setState(() {
                            _capturedImagePath = null;
                            _descController.clear();
                          });
                        }
                      } catch (e) {
                        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      } finally {
                        if (mounted) setState(() => _isSubmitting = false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 5, shadowColor: primaryRed.withOpacity(0.4),
                    ),
                    child: _isSubmitting 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Kirim Laporan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                SizedBox(height: 100), // Ruang ekstra untuk navigasi
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helpers
  Widget _label(String text) => Padding(padding: EdgeInsets.only(bottom: 8), child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.shade700)));
  
  InputDecoration _inputDeco(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
    filled: true, fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  );

  Widget _buildCircleBtn(IconData icon) => CircleAvatar(
    backgroundColor: Colors.black26, radius: 18,
    child: Icon(icon, color: Colors.white, size: 18),
  );

  Widget _buildSquareBtn(IconData icon) => Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
    child: Icon(icon, color: Colors.white, size: 20),
  );
}