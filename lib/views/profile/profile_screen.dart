import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:jalan_in/core/theme/app_theme.dart';
import 'package:jalan_in/views/auth/login_screen.dart';
import 'package:jalan_in/widgets/notification_dialog.dart';
import 'package:jalan_in/models/report_model.dart';
import 'package:jalan_in/views/report/report_detail_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Profile Section
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.inputBackgroundColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    'ANGGOTA KOMUNITAS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AppTheme.textColor.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aditya Wijaya',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'aditya.wijaya@jakarta.go.id',
                    style: TextStyle(
                      color: AppTheme.textLightColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showEditProfileSheet(context);
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Ubah Profil'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 48),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    icon: const Icon(Icons.logout, color: AppTheme.primaryColor, size: 20),
                    label: const Text(
                      'Keluar',
                      style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            
            // History Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Laporan Anda',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lacak status laporan jalan yang Anda kirimkan',
                    style: TextStyle(
                      color: AppTheme.textLightColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildHistoryItem(
                    context,
                    ReportModel(
                      id: 'h1',
                      status: 'DILAPORKAN',
                      statusColor: AppTheme.statusDilaporkan,
                      statusBgColor: const Color(0xFFFDECE9),
                      title: 'Lubang besar di jalan...',
                      address: 'Jakarta Pusat',
                      timeReported: '24 OKT 2023',
                      imageUrl: 'https://picsum.photos/200?random=1',
                      location: const LatLng(-6.200, 106.816),
                    ),
                  ),
                  _buildHistoryItem(
                    context,
                    ReportModel(
                      id: 'h2',
                      status: 'DIPROSES',
                      statusColor: AppTheme.statusDiproses,
                      statusBgColor: const Color(0xFFE3F2FD),
                      title: 'Trotorar retak di...',
                      address: 'Jakarta Selatan',
                      timeReported: '18 OKT 2023',
                      imageUrl: 'https://picsum.photos/200?random=2',
                      location: const LatLng(-6.205, 106.820),
                    ),
                  ),
                  _buildHistoryItem(
                    context,
                    ReportModel(
                      id: 'h3',
                      status: 'SELESAI',
                      statusColor: AppTheme.statusSelesai,
                      statusBgColor: const Color(0xFFE8F5E9),
                      title: 'Zebra cross pudar di...',
                      address: 'Jakarta Timur',
                      timeReported: '12 OKT 2023',
                      imageUrl: 'https://picsum.photos/200?random=3',
                      location: const LatLng(-6.195, 106.810),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, ReportModel report) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportDetailScreen(report: report),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.inputBackgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                report.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: report.statusBgColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          report.status,
                          style: TextStyle(
                            color: report.statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        report.timeReported,
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    report.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          report.address.replaceAll('\n', ' '),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ubah Profil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                controller: TextEditingController(text: 'Aditya Wijaya'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan alamat email',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                controller: TextEditingController(text: 'aditya.wijaya@jakarta.go.id'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profil berhasil diperbarui')),
                  );
                },
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        );
      },
    );
  }
}

