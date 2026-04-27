import 'package:flutter/material.dart';
import 'package:jalan_in/core/theme/app_theme.dart';
import 'package:jalan_in/widgets/notification_dialog.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _descController = TextEditingController();
  bool _isFlashOn = false;
  bool _isCaptured = false;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'jalan.in',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const NotificationDialog(),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera View Placeholder
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(_isCaptured ? 'https://picsum.photos/600/400?random=1' : 'https://picsum.photos/600/400?random=2'),
                fit: BoxFit.cover,
                colorFilter: _isCaptured ? null : ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Focus Frame
                if (!_isCaptured)
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                // Camera Controls
                Positioned(
                  bottom: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_isCaptured) _buildIconButton(Icons.photo_library, () {}),
                      if (_isCaptured)
                        _buildIconButton(Icons.close, () {
                          setState(() {
                            _isCaptured = false;
                          });
                        }),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCaptured = !_isCaptured;
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            color: _isCaptured ? AppTheme.primaryColor : Colors.transparent,
                          ),
                          child: _isCaptured ? const Icon(Icons.check, color: Colors.white, size: 32) : null,
                        ),
                      ),
                      const SizedBox(width: 30),
                      if (!_isCaptured) _buildIconButton(Icons.flip_camera_ios, () {}),
                      if (_isCaptured) const SizedBox(width: 44),
                    ],
                  ),
                ),
                // GPS Tag
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'GPS AKTIF: -6.2000° S',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFlashOn = !_isFlashOn;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Form Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'DESKRIPSI',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: AppTheme.textColor.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: _descController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Deskripsikan tingkat keparahan\ndan catatan lokasi spesifik...',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.inputBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.my_location, color: AppTheme.primaryColor),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'TITIK LOKASI',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Jalan Sudirman,\nJakarta Pusat',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (!_isCaptured) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Silakan ambil foto terlebih dahulu')),
                          );
                          return;
                        }
                        if (_descController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Silakan isi deskripsi laporan')),
                          );
                          return;
                        }
                        _showSuccessDialog();
                      },
                      child: const Text('Kirim Laporan'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.green, size: 64),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Laporan Berhasil!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Terima kasih! Laporan Anda telah masuk ke sistem dan akan segera ditindaklanjuti.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    setState(() {
                      _isCaptured = false;
                      _descController.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Kembali ke Laporan Baru'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

