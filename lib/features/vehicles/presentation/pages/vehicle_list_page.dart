import 'package:drivelist/core/appcolors.dart';
import 'package:drivelist/features/vehicles/presentation/pages/add_vehicle_page.dart';
import 'package:drivelist/features/vehicles/presentation/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/vehicle_controller.dart';
import '../widgets/vehicle_card.dart';

class VehicleListPage extends StatelessWidget {
  const VehicleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleController());

    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      appBar: AppBar(
        backgroundColor: AppColors.creamWhite,
        elevation: 0,
        title: const Text(
          'Drive List',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: AppColors.textDark,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const AddVehicleSheet(),
        ),
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Vehicle',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue));
        }

        if (controller.vehicleList.isEmpty) {
          return const EmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
          itemCount: controller.vehicleList.length,
          itemBuilder: (_, index) =>
              VehicleCard(vehicle: controller.vehicleList[index]),
        );
      }),
    );
  }
}

