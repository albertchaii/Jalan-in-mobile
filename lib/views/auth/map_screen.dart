import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Package khusus koordinat untuk flutter_map

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Color primaryRed = const Color(0xFF8A0B14);
  final Color bgPink = const Color(0xFFFEF9F9);
  
  // Koordinat default (Telkom University / Bandung Raya)
  final LatLng _center = const LatLng(-6.974001, 107.630348);

  bool _showDetailCard = true; // Set true untuk preview Card di bawah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPink,
      appBar: AppBar(
        backgroundColor: bgPink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF8A0B14)),
          onPressed: () {},
        ),
        title: const Text(
          'jalan.in',
          style: TextStyle(
            color: Color(0xFF8A0B14),
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF8A0B14)),
            onPressed: () {},
          ),
        ],
      ),
      
      body: Stack(
        children: [
          // Lapis 1: flutter_map (Leaflet)
          FlutterMap(
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15.0,
              // Batasi pergerakan peta agar tidak terlalu jauh (opsional)
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate, // Matikan rotasi agar peta tegak
              ),
            ),
            children: [
              // Mengambil gambar peta dari OpenStreetMap
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.jalan_in.app',
                // Nanti Anda bisa mengganti URL template ini dengan style peta Dark Mode 
                // dari penyedia pihak ketiga seperti Mapbox atau Stadia Maps secara gratis.
              ),
              // Layer untuk menaruh pin / marker
              MarkerLayer(
                markers: [
                  // Contoh Marker Status Dilaporkan (Merah)
                  Marker(
                    point: const LatLng(-6.974001, 107.630348),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                  ),
                  // Contoh Marker Status Disurvei (Kuning)
                  Marker(
                    point: const LatLng(-6.972000, 107.632000),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.amber, size: 40),
                  ),
                ],
              ),
            ],
          ),

          // Lapis 2: Legend Keterangan Warna
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(Colors.red.shade700, 'DILAPORKAN'),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.yellow.shade600, 'DISURVEI'),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.blue.shade900, 'DIPROSES'),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.green.shade600, 'SELESAI'),
                ],
              ),
            ),
          ),

          // Lapis 3: Tombol Plus Besar
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: primaryRed,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: primaryRed.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 32),
                onPressed: () {
                  // TODO: Navigasi ke CameraScreen
                },
              ),
            ),
          ),

          // Lapis 4: Kartu Detail Bottom Sheet
          if (_showDetailCard)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 5))
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image, color: Colors.grey),
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
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'MASALAH MENDESAK',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryRed),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Lubang Besar di\nJalan Sudirman',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.2),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                                  const SizedBox(width: 4),
                                  Text('Dilaporkan 2 jam lalu', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility),
                            label: const Text('Lihat Detail', style: TextStyle(fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.directions, color: primaryRed),
                            onPressed: () {},
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade800, letterSpacing: 0.5),
        ),
      ],
    );
  }
}