
import 'package:drivelist/core/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/vehicle_controller.dart';
import '../../data/vehicle_model.dart';

class VehicleDetailPage extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleDetailPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Image Section 
            _buildImageSection(),

            //  Content 
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Model name + badges
                  Text(
                    vehicle.vehicleModel,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _badge(vehicle.manufacturingYear,
                          AppColors.accentGold, Icons.calendar_today_rounded),
                      const SizedBox(width: 8),
                      _badge(vehicle.vehicleColor,
                          AppColors.primaryBlue, Icons.palette_rounded),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(color: AppColors.creamGrey),
                  const SizedBox(height: 20),

                 
                  const Text(
                    'Specifications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.6,
                    children: [
                      _specCard(Icons.directions_car_rounded,
                          'Model', vehicle.vehicleModel, AppColors.primaryBlue),
                      _specCard(Icons.palette_rounded,
                          'Color', vehicle.vehicleColor, const Color(0xFF8B5CF6)),
                      _specCard(Icons.tire_repair_rounded,
                          'Wheel', vehicle.wheelType, const Color(0xFF059669)),
                      _specCard(Icons.calendar_today_rounded,
                          'Year', vehicle.manufacturingYear, AppColors.accentGold),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Detail Rows ──
                  const Text(
                    'Full Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _detailRow('Vehicle Model', vehicle.vehicleModel,
                      Icons.directions_car_outlined),
                  _detailRow('Color', vehicle.vehicleColor,
                      Icons.palette_outlined),
                  _detailRow('Wheel Type', vehicle.wheelType,
                      Icons.tire_repair_outlined),
                  _detailRow('Manufacturing Year', vehicle.manufacturingYear,
                      Icons.calendar_today_outlined),

                  const SizedBox(height: 28),

                  // ── Delete Button ──
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final ctrl = Get.find<VehicleController>();
                        ctrl.deleteVehicle(vehicle.id, vehicle.vehicleModel);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        foregroundColor: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.red.shade200),
                        ),
                      ),
                      icon: const Icon(Icons.delete_outline_rounded, size: 18),
                      label: const Text(
                        'Delete Vehicle',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Image with back button overlaid ──
  Widget _buildImageSection() {
    return Stack(
      children: [
        // Image
        SizedBox(
          width: double.infinity,
          height: 280,
          child: vehicle.vehicleImage.isNotEmpty
              ? Image.network(
                  vehicle.vehicleImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: AppColors.creamGrey,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryBlue, strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => _placeholder(),
                )
              : _placeholder(),
        ),

        // Dark gradient at bottom of image
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.creamWhite,
                ],
              ),
            ),
          ),
        ),

        // Back button
        Positioned(
          top: MediaQuery.of(Get.context!).padding.top + 8,
          left: 12,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: AppColors.textDark),
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.creamGrey,
      child: const Center(
        child: Icon(Icons.directions_car_outlined,
            size: 64, color: AppColors.textMuted),
      ),
    );
  }

  Widget _badge(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
                color: color, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _specCard(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 10,
                      color: color.withOpacity(0.8),
                      fontWeight: FontWeight.w500)),
              Text(
                value.isEmpty ? '—' : value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.creamGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textMuted)),
                Text(
                  value.isEmpty ? '—' : value,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}