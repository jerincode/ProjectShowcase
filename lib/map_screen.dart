import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class CollegeMapScreen extends StatefulWidget {
  const CollegeMapScreen({super.key});

  @override
  State<CollegeMapScreen> createState() => _CollegeMapScreenState();
}

class _CollegeMapScreenState extends State<CollegeMapScreen> {
  // Thiagarajar College of Engineering, Madurai
  static const LatLng _tceLocation = LatLng(9.88162, 78.0798);
  final MapController _mapController = MapController();
  double _currentZoom = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Campus Location',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _tceLocation,
              initialZoom: _currentZoom,
              minZoom: 10,
              maxZoom: 19,
              onMapEvent: (event) {
                if (event is MapEventMove) {
                  setState(() => _currentZoom = event.camera.zoom);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.proj',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _tceLocation,
                    width: 80,
                    height: 80,
                    child: _CollegeMarker(),
                  ),
                ],
              ),
            ],
          ),
          // Info card
          Positioned(
            left: 16, right: 16, bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E1E35), Color(0xFF16213E)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.4), width: 1.2),
                boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF4A42D6)]),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.school_rounded, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Thiagarajar College of Engineering',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text('Thiruparankundram, Madurai � 625 015',
                          style: GoogleFonts.poppins(color: const Color(0xFF9999BB), fontSize: 12)),
                        const SizedBox(height: 2),
                        Text('9.8942� N, 78.0695� E',
                          style: GoogleFonts.poppins(color: const Color(0xFF00D4AA), fontSize: 11, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Zoom controls
          Positioned(
            right: 16, top: 16,
            child: Column(
              children: [
                _ZoomButton(icon: Icons.add, onTap: () => _mapController.move(_mapController.camera.center, (_currentZoom + 1).clamp(10.0, 19.0))),
                const SizedBox(height: 8),
                _ZoomButton(icon: Icons.remove, onTap: () => _mapController.move(_mapController.camera.center, (_currentZoom - 1).clamp(10.0, 19.0))),
                const SizedBox(height: 8),
                _ZoomButton(icon: Icons.my_location_rounded, onTap: () => _mapController.move(_tceLocation, 16.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CollegeMarker extends StatefulWidget {
  @override
  State<_CollegeMarker> createState() => _CollegeMarkerState();
}

class _CollegeMarkerState extends State<_CollegeMarker> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.85, end: 1.15).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, __) => Transform.scale(
        scale: _pulse.value,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF4A42D6)]),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.6), blurRadius: 12, spreadRadius: 2)],
              ),
              child: const Icon(Icons.school_rounded, color: Colors.white, size: 22),
            ),
            CustomPaint(size: const Size(12, 8), painter: _TailPainter()),
          ],
        ),
      ),
    );
  }
}

class _TailPainter extends CustomPainter {
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final path = ui.Path()..moveTo(0, 0)..lineTo(size.width / 2, size.height)..lineTo(size.width, 0)..close();
    canvas.drawPath(path, ui.Paint()..color = const Color(0xFF6C63FF));
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42, height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E35),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2A45)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}



