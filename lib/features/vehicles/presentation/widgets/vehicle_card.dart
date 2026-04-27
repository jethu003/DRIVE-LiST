import 'package:drivelist/core/appcolors.dart';
import 'package:drivelist/features/vehicles/presentation/pages/vehicle_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/vehicle_model.dart';


class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => VehicleDetailPage(vehicle: vehicle),
        transition: Transition.cupertino,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.creamGrey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Vehicle Image ──
            Hero(
              tag: 'vehicle-${vehicle.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: vehicle.vehicleImage.isNotEmpty
                    ? Image.network(
                        vehicle.vehicleImage,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),

            // ── Details ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.vehicleModel,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _infoRow(Icons.calendar_today_outlined, vehicle.manufacturingYear),
                    const SizedBox(height: 4),
                    _infoRow(Icons.palette_outlined, vehicle.vehicleColor),
                    const SizedBox(height: 4),
                    _infoRow(Icons.tire_repair_outlined, vehicle.wheelType),
                  ],
                ),
              ),
            ),

            // ── Arrow ──
            const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(Icons.arrow_forward_ios_rounded,
                  size: 15, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.primaryBlue),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      width: 110,
      height: 110,
      color: AppColors.creamWhite,
      child: const Icon(Icons.directions_car,
          size: 40, color: AppColors.primaryBlue),
    );
  }
}