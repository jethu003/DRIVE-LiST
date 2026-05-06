import 'package:drivelist/core/appcolors.dart';
import 'package:drivelist/features/vehicles/presentation/widgets/imagepicker.dart';
import 'package:drivelist/features/vehicles/presentation/widgets/vehicleformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/vehicle_controller.dart';
import '../../data/vehicle_model.dart';

class AddVehicleSheet extends StatefulWidget {
  const AddVehicleSheet({super.key});

  @override
  State<AddVehicleSheet> createState() => _AddVehicleSheetState();
}

class _AddVehicleSheetState extends State<AddVehicleSheet> {
  final _formKey = GlobalKey<FormState>();

  final _modelCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  final _wheelCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();

  final VehicleController _controller = Get.find();

  String? _uploadedImageUrl;

  @override
  void dispose() {
    _modelCtrl.dispose();
    _colorCtrl.dispose();
    _wheelCtrl.dispose();
    _yearCtrl.dispose();
    _controller.clearPickedImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.creamWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DragHandle(),
              const SizedBox(height: 16),
              _SheetTitle(),
              const SizedBox(height: 22),

              ImagePickerTile(
                onUploaded: (url) => _uploadedImageUrl = url,
              ),
              const SizedBox(height: 16),

              VehicleFormField(
                controller: _modelCtrl,
                label: 'Vehicle Model',
                icon: Icons.directions_car_outlined,
                hint: 'e.g. Swift, Creta, Nexon',
              ),
              VehicleFormField(
                controller: _colorCtrl,
                label: 'Color',
                icon: Icons.palette_outlined,
                hint: 'e.g. Pearl White, Midnight Blue',
              ),
              VehicleFormField(
                controller: _wheelCtrl,
                label: 'Wheel Type',
                icon: Icons.tire_repair_outlined,
                hint: 'e.g. Alloy, Steel, Performance',
              ),
              VehicleFormField(
                controller: _yearCtrl,
                label: 'Manufacturing Year',
                icon: Icons.calendar_today_outlined,
                hint: 'e.g. 2023',
                keyboardType: TextInputType.number,
                validator: _validateYear,
              ),

              const SizedBox(height: 24),
              _SaveButton(
                controller: _controller,
                onSave: _save,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateYear(String? v) {
    if (v == null || v.isEmpty) return 'Required';
    final y = int.tryParse(v);
    if (y == null || y < 1886 || y > DateTime.now().year + 1) {
      return 'Enter a valid year';
    }
    return null;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final model = VehicleModel(
        vehicleModel: _modelCtrl.text.trim(),
        vehicleColor: _colorCtrl.text.trim(),
        wheelType: _wheelCtrl.text.trim(),
        manufacturingYear: _yearCtrl.text.trim(),
        vehicleImage: _uploadedImageUrl ?? '',
      );
      _controller.addVehicle(model);
    }
  }
}

// ── Private sub-widgets ──

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _SheetTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.directions_car,
            color: AppColors.primaryBlue,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Add New Vehicle',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VehicleController controller;
  final VoidCallback onSave;

  const _SaveButton({required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              disabledBackgroundColor: AppColors.primaryBlue.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            onPressed: (controller.isSaving.value ||
                    controller.isUploadingImage.value)
                ? null
                : onSave,
            child: controller.isSaving.value
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Text(
                    'Save Vehicle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ));
  }
}