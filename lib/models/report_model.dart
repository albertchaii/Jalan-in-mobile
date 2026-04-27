import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ReportModel {
  final String id;
  final String title;
  final String address;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final String timeReported;
  final String imageUrl;
  final LatLng location;

  ReportModel({
    required this.id,
    required this.title,
    required this.address,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.timeReported,
    required this.imageUrl,
    required this.location,
  });
}
