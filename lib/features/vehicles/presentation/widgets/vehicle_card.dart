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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
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
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.vehicleModel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),

                      _infoRow(Icons.calendar_today_outlined,
                          vehicle.manufacturingYear),
                      const SizedBox(height: 5),

                      _infoRow(
                          Icons.palette_outlined, vehicle.vehicleColor),
                      const SizedBox(height: 5),

                      _infoRow(
                          Icons.tire_repair_outlined, vehicle.wheelType),
                    ],
                  ),
                ),
              ),

              
              Hero(
                tag: 'vehicle-${vehicle.id}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
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

              // 🔹 Arrow icon
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Info row widget
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.primaryBlue),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textMuted,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // 🔹 Placeholder if image fails
  Widget _placeholder() {
    return Container(
      width: 110,
      height: 110,
      color: AppColors.creamWhite,
      child: const Icon(
        Icons.directions_car,
        size: 40,
        color: AppColors.primaryBlue,
      ),
    );
  }
}