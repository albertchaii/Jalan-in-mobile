import 'package:flutter/material.dart';
import 'package:jalan_in/core/theme/app_theme.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifikasi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'TANDAI SEMUA DIBACA',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildNotificationItem(
              icon: Icons.check_circle,
              iconColor: AppTheme.statusSelesai,
              title: 'Laporan Selesai',
              subtitle: 'Laporan Anda di Jalan Sudirman telah selesai.',
              time: '2 jam lalu',
            ),
            _buildNotificationItem(
              icon: Icons.favorite,
              iconColor: AppTheme.primaryColor,
              title: 'Dukungan Baru',
              subtitle: 'Seseorang mendukung laporan Anda di Tanah Abang.',
              time: '5 jam lalu',
            ),
            _buildNotificationItem(
              icon: Icons.calendar_today,
              iconColor: Colors.blue,
              title: 'Perbaikan Dijadwalkan',
              subtitle: 'Perbaikan Jalan Thamrin dijadwalkan pada 30 Okt.',
              time: 'Kemarin',
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: Text(
                  'LIHAT SEMUA NOTIFIKASI',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

