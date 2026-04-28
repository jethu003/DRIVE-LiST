import 'dart:io';
import 'package:drivelist/core/appcolors.dart';
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

  final VehicleController controller = Get.find();

  String? _uploadedImageUrl;

  @override
  void dispose() {
    _modelCtrl.dispose();
    _colorCtrl.dispose();
    _wheelCtrl.dispose();
    _yearCtrl.dispose();
    controller.clearPickedImage();
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
              // Drag Handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Row(
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
              ),
              const SizedBox(height: 22),

              // Image Picker
              _ImagePickerTile(
                onUploaded: (url) => _uploadedImageUrl = url,
              ),
              const SizedBox(height: 16),

              // Fields
              _buildField(
                _modelCtrl,
                'Vehicle Model',
                Icons.directions_car_outlined,
                hint: 'e.g. Swift, Creta, Nexon',
              ),
              _buildField(
                _colorCtrl,
                'Color',
                Icons.palette_outlined,
                hint: 'e.g. Pearl White, Midnight Blue',
              ),
              _buildField(
                _wheelCtrl,
                'Wheel Type',
                Icons.tire_repair_outlined,
                hint: 'e.g. Alloy, Steel, Performance',
              ),
              _buildField(
                _yearCtrl,
                'Manufacturing Year',
                Icons.calendar_today_outlined,
                hint: 'e.g. 2023',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final y = int.tryParse(v);
                  if (y == null ||
                      y < 1886 ||
                      y > DateTime.now().year + 1) {
                    return 'Enter a valid year';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Save Button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        disabledBackgroundColor:
                            AppColors.primaryBlue.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: (controller.isSaving.value ||
                              controller.isUploadingImage.value)
                          ? null
                          : _save,
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
                  )),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
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

      controller.addVehicle(model);
    }
  }

  Widget _buildField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    bool required = true,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        validator: validator ??
            (required
                ? (v) => (v == null || v.trim().isEmpty)
                    ? '$label is required'
                    : null
                : null),
        decoration: InputDecoration(
          prefixIcon: Icon(icon,
              color: AppColors.primaryBlue, size: 20),
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.creamGrey,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 14, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Colors.red, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: AppColors.primaryBlue, width: 1.5),
          ),
        ),
      ),
    );
  }
}

// ================= IMAGE PICKER =================

class _ImagePickerTile extends StatefulWidget {
  final void Function(String url) onUploaded;

  const _ImagePickerTile({required this.onUploaded});

  @override
  State<_ImagePickerTile> createState() => _ImagePickerTileState();
}

class _ImagePickerTileState extends State<_ImagePickerTile> {
  File? _localFile;
  String? _uploadedUrl;

  final VehicleController _ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.creamGrey,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _uploadedUrl != null
                ? Colors.green.shade400
                : AppColors.primaryBlue.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Obx(() {
          // Uploading
          if (_ctrl.isUploadingImage.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryBlue,
                  strokeWidth: 2.5,
                ),
                const SizedBox(height: 10),
                Text(
                  'Please Wait...',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600),
                ),
              ],
            );
          }

          // Preview
          if (_localFile != null) {
            return Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.file(_localFile!,
                      fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _uploadedUrl != null
                          ? Colors.green
                          : Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _uploadedUrl != null
                          ? '✓ Uploaded'
                          : '⚠ Failed',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // Empty
          return const Center(
            child: Text('Tap to pick vehicle image'),
          );
        }),
      ),
    );
  }

  Future<void> _pickImage() async {
    final url = await _ctrl.pickAndUploadImage();

    if (url != null) {
      setState(() {
        _localFile = _ctrl.pickedImageFile.value;
        _uploadedUrl = url;
      });
      widget.onUploaded(url);
    } else if (_ctrl.pickedImageFile.value != null) {
      setState(() {
        _localFile = _ctrl.pickedImageFile.value;
        _uploadedUrl = null;
      });
    }
  }
}