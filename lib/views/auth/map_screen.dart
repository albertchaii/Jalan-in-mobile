import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:jalan_in/core/theme/app_theme.dart';
import 'package:jalan_in/widgets/notification_dialog.dart';
import 'package:jalan_in/models/report_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  ReportModel? _selectedReport;

  final List<ReportModel> _reports = [
    ReportModel(
      id: '1',
      title: 'Lubang Besar di Jalan Sudirman',
      address: 'Jalan Sudirman, Jakarta Pusat',
      status: 'DILAPORKAN',
      statusColor: AppTheme.statusDilaporkan,
      statusBgColor: const Color(0xFFFDECE9),
      timeReported: 'Dilaporkan 2 jam lalu',
      imageUrl: 'https://picsum.photos/200?random=4',
      location: const LatLng(-6.200000, 106.816666),
    ),
    ReportModel(
      id: '2',
      title: 'Trotorar retak di Kemang',
      address: 'Jalan Kemang Raya, Jakarta Selatan',
      status: 'DIPROSES',
      statusColor: AppTheme.statusDiproses,
      statusBgColor: const Color(0xFFE3F2FD),
      timeReported: 'Dilaporkan 5 jam lalu',
      imageUrl: 'https://picsum.photos/200?random=5',
      location: const LatLng(-6.205000, 106.820000),
    ),
    ReportModel(
      id: '3',
      title: 'Zebra cross pudar di Thamrin',
      address: 'Jalan MH Thamrin, Jakarta Pusat',
      status: 'SELESAI',
      statusColor: AppTheme.statusSelesai,
      statusBgColor: const Color(0xFFE8F5E9),
      timeReported: 'Selesai 1 hari lalu',
      imageUrl: 'https://picsum.photos/200?random=6',
      location: const LatLng(-6.195000, 106.810000),
    ),
    ReportModel(
      id: '4',
      title: 'Lampu jalan mati',
      address: 'Jalan Gatot Subroto, Jakarta',
      status: 'DISURVEI',
      statusColor: AppTheme.statusDisurvei,
      statusBgColor: const Color(0xFFFFF9C4),
      timeReported: 'Dilaporkan 1 hari lalu',
      imageUrl: 'https://picsum.photos/200?random=7',
      location: const LatLng(-6.198000, 106.825000),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Default select the first report
    _selectedReport = _reports[0];
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
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(-6.200000, 106.816666),
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _reports.map((report) {
                  return Marker(
                    point: report.location,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedReport = report;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: report.statusColor,
                            size: _selectedReport?.id == report.id ? 50 : 40,
                          ),
                          if (_selectedReport?.id == report.id)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // Legend
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLegendItem('DILAPORKAN', AppTheme.statusDilaporkan),
                  _buildLegendItem('DISURVEI', AppTheme.statusDisurvei),
                  _buildLegendItem('DIPROSES', AppTheme.statusDiproses),
                  _buildLegendItem('SELSAI', AppTheme.statusSelesai),
                ],
              ),
            ),
          ),
          // Add button
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gunakan tab Lapor di bawah untuk membuat laporan')),
                );
              },
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
          // Bottom Card
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _buildBottomCard(context),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard(BuildContext context) {
    if (_selectedReport == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _selectedReport!.imageUrl,
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _selectedReport!.statusBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _selectedReport!.status,
                        style: TextStyle(
                          color: _selectedReport!.statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedReport!.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _selectedReport!.timeReported,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye),
                  label: const Text('Lihat Detail'),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.directions_outlined, color: AppTheme.primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

