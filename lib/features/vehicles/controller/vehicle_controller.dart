import 'dart:io';
import 'package:drivelist/features/vehicles/data/cloudinary_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/vehicle_data.dart';
import '../data/vehicle_model.dart';

class VehicleController extends GetxController {
  final VehicleData _data = VehicleData();
  final ImagePicker _picker = ImagePicker();

  var vehicleList = <VehicleModel>[].obs;
  var isLoading = true.obs;
  var isSaving = false.obs;
  var pickedImageFile = Rxn<File>();
  var isUploadingImage = false.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToVehicles();
  }


  void _listenToVehicles() {
    _data.getVehiclesStream().listen(
      (data) {
        vehicleList.value = data;
        isLoading.value = false;
      },
      onError: (e) {
        isLoading.value = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Get.isOverlaysOpen) return;
          Get.snackbar(
            'Connection Error',
            'Could not load vehicles.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade100,
            duration: const Duration(seconds: 3),
          );
        });
      },
    );
  }

 
  Future<String?> pickAndUploadImage() async {
    XFile? picked;

    try {
      picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1200,
      );
    } catch (e) {
     
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Plugin Error',
          'Image picker not available. Try restarting the app.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.shade100,
        );
      });
      return null;
    }

    if (picked == null) return null; 

    pickedImageFile.value = File(picked.path);
    isUploadingImage.value = true;

    final url = await CloudinaryService.uploadImage(pickedImageFile.value!);

    isUploadingImage.value = false;

    if (url == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Upload Failed',
          'Could not upload image. Try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
      });
    }

    return url;
  }

  void clearPickedImage() {
    pickedImageFile.value = null;
  }


  Future<void> addVehicle(VehicleModel model) async {
    isSaving.value = true;
    try {
      await _data.addVehicle(model);
      clearPickedImage();
      Get.back();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          ' Added',
          '${model.vehicleModel} added to your fleet!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          duration: const Duration(seconds: 2),
        );
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
      });
    } finally {
      isSaving.value = false;
    }
  }


  Future<void> deleteVehicle(String id, String name) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Vehicle'),
        content: Text('Remove "$name" from your fleet?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _data.deleteVehicle(id);
      
      if (Get.currentRoute != '/') {
        Get.back();
      }
    }
  }
}