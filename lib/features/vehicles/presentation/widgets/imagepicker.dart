import 'dart:io';

import 'package:drivelist/core/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/vehicle_controller.dart';

class ImagePickerTile extends StatefulWidget {
  final void Function(String url) onUploaded;

  const ImagePickerTile({super.key, required this.onUploaded});

  @override
  State<ImagePickerTile> createState() => _ImagePickerTileState();
}

class _ImagePickerTileState extends State<ImagePickerTile> {
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
          if (_ctrl.isUploadingImage.value) {
            return _UploadingIndicator();
          }
          if (_localFile != null) {
            return _ImagePreview(
              file: _localFile!,
              uploadedUrl: _uploadedUrl,
            );
          }
          return const _EmptyPlaceholder();
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

// ── Sub-widgets ──

class _UploadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final File file;
  final String? uploadedUrl;

  const _ImagePreview({required this.file, required this.uploadedUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Image.file(file, fit: BoxFit.cover),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _UploadStatusBadge(isUploaded: uploadedUrl != null),
        ),
      ],
    );
  }
}

class _UploadStatusBadge extends StatelessWidget {
  final bool isUploaded;

  const _UploadStatusBadge({required this.isUploaded});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isUploaded ? Colors.green : Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isUploaded ? '✓ Uploaded' : '⚠ Failed',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tap to pick vehicle image'),
    );
  }
}