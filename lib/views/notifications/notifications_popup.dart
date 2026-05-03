import 'package:flutter/material.dart';

const _primaryRed = Color(0xFF8A0B14);

Future<void> showNotificationsPopup(BuildContext context) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'notifications',
    barrierColor: Colors.black.withOpacity(0.15),
    transitionDuration: const Duration(milliseconds: 140),
    pageBuilder: (context, _, _) {
      return SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 64, right: 16),
            child: _NotificationsCard(
              items: const [
                _NotificationItem(
                  icon: Icons.check_circle,
                  iconColor: Color(0xFF14A44D),
                  title: 'Laporan Selesai',
                  message: 'Laporan Anda di Jalan Sudirman telah selesai.',
                  timeLabel: '2 jam lalu',
                ),
                _NotificationItem(
                  icon: Icons.favorite,
                  iconColor: _primaryRed,
                  title: 'Dukungan Baru',
                  message: 'Seseorang mendukung laporan Anda di Tanah Abang.',
                  timeLabel: '5 jam lalu',
                ),
                _NotificationItem(
                  icon: Icons.calendar_month,
                  iconColor: Color(0xFF2F6BFF),
                  title: 'Perbaikan Dijadwalkan',
                  message: 'Perbaikan Jalan Thamrin dijadwalkan pada 30 Okt.',
                  timeLabel: 'Kemarin',
                ),
              ],
              onMarkAllRead: () => Navigator.of(context).pop(),
              onSeeAll: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim, _, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
          alignment: Alignment.topRight,
          child: child,
        ),
      );
    },
  );
}

class _NotificationsCard extends StatelessWidget {
  const _NotificationsCard({
    required this.items,
    required this.onMarkAllRead,
    required this.onSeeAll,
  });

  final List<_NotificationItem> items;
  final VoidCallback onMarkAllRead;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 28,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
              child: Row(
                children: [
                  const Text(
                    'Notifikasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: onMarkAllRead,
                    style: TextButton.styleFrom(
                      foregroundColor: _primaryRed,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
                    ),
                    child: const Text('TANDAI SEMUA DIBACA'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _NotificationRow(item: items[i]),
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: onSeeAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'LIHAT SEMUA NOTIFIKASI',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    color: Colors.black.withOpacity(0.32),
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

class _NotificationItem {
  const _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.timeLabel,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String timeLabel;
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: item.iconColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item.icon, color: item.iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.message,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.25,
                  color: Colors.black.withOpacity(0.55),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.timeLabel,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black.withOpacity(0.35),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

