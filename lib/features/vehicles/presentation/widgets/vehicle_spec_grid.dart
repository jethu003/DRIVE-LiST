import 'package:drivelist/core/appcolors.dart';
import 'package:flutter/material.dart';

import '../../data/vehicle_model.dart';

class VehicleSpecGrid extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleSpecGrid({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final specs = [
      _SpecItem(Icons.directions_car_rounded, 'Model',
          vehicle.vehicleModel, AppColors.primaryBlue),
      _SpecItem(Icons.palette_rounded, 'Color',
          vehicle.vehicleColor, const Color(0xFF8B5CF6)),
      _SpecItem(Icons.tire_repair_rounded, 'Wheel',
          vehicle.wheelType, const Color(0xFF059669)),
      _SpecItem(Icons.calendar_today_rounded, 'Year',
          vehicle.manufacturingYear, AppColors.accentGold),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.6,
      children: specs.map((s) => _SpecCard(spec: s)).toList(),
    );
  }
}

class _SpecItem {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SpecItem(this.icon, this.label, this.value, this.color);
}

class _SpecCard extends StatelessWidget {
  final _SpecItem spec;

  const _SpecCard({required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: spec.color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        // ignore: deprecated_member_use
        border: Border.all(color: spec.color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(spec.icon, color: spec.color, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                spec.label,
                style: TextStyle(
                  fontSize: 10,
                  // ignore: deprecated_member_use
                  color: spec.color.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                spec.value.isEmpty ? '—' : spec.value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}