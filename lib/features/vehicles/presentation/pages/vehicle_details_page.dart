// import 'package:drivelist/core/appcolors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/vehicle_controller.dart';
// import '../../data/vehicle_model.dart';

// class VehicleDetailPage extends StatelessWidget {
//   final VehicleModel vehicle;

//   const VehicleDetailPage({super.key, required this.vehicle});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.creamWhite,
//       body: CustomScrollView(
//         slivers: [
//           //Hero App Bar with image ──
//           SliverAppBar(
//             expandedHeight: 320,
//             pinned: true,
//             backgroundColor: AppColors.darkBlue,
//             automaticallyImplyLeading: false,
//             leading: GestureDetector(
//               onTap: () => Get.back(),
//               child: Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.arrow_back_ios_new_rounded,
//                     color: Colors.white, size: 18),
//               ),
//             ),
//             actions: [
//               GestureDetector(
//                 onTap: () {
//                   final ctrl = Get.find<VehicleController>();
//                   ctrl.deleteVehicle(vehicle.id, vehicle.vehicleModel);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(8),
//                   padding: const EdgeInsets.all(7),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(Icons.delete_outline_rounded,
//                       color: Colors.white, size: 20),
//                 ),
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // ✅ Vehicle image with Hero animation
//                   Hero(
//                     tag: 'vehicle-${vehicle.id}',
//                     child: _buildHeroImage(),
//                   ),
//                   // Gradient overlay
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.black.withOpacity(0.1),
//                           AppColors.darkBlue.withOpacity(0.9),
//                         ],
//                         stops: const [0.3, 1.0],
//                       ),
//                     ),
//                   ),
//                   // Vehicle name + year badge at bottom
//                   Positioned(
//                     bottom: 20,
//                     left: 20,
//                     right: 20,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           vehicle.vehicleModel,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Row(
//                           children: [
//                             _badge(
//                               vehicle.manufacturingYear,
//                               AppColors.accentGold,
//                               Icons.calendar_today_rounded,
//                             ),
//                             const SizedBox(width: 8),
//                             _badge(
//                               vehicle.vehicleColor,
//                               AppColors.primaryBlue,
//                               Icons.palette_rounded,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ── Body Content ──
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Specifications',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textDark,
//                       letterSpacing: 0.4,
//                     ),
//                   ),
//                   const SizedBox(height: 14),

//                   // ── 2x2 Spec Grid ──
//                   GridView.count(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     childAspectRatio: 1.5,
//                     children: [
//                       _specCard(
//                         icon: Icons.directions_car_rounded,
//                         label: 'Model',
//                         value: vehicle.vehicleModel,
//                         color: AppColors.primaryBlue,
//                       ),
//                       _specCard(
//                         icon: Icons.palette_rounded,
//                         label: 'Color',
//                         value: vehicle.vehicleColor,
//                         color: const Color(0xFF8B5CF6),
//                       ),
//                       _specCard(
//                         icon: Icons.tire_repair_rounded,
//                         label: 'Wheel Type',
//                         value: vehicle.wheelType,
//                         color: const Color(0xFF059669),
//                       ),
//                       _specCard(
//                         icon: Icons.calendar_today_rounded,
//                         label: 'Year',
//                         value: vehicle.manufacturingYear,
//                         color: AppColors.accentGold,
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   const Text(
//                     'Full Details',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textDark,
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   _detailRow('Vehicle Model', vehicle.vehicleModel,
//                       Icons.directions_car_outlined),
//                   _detailRow('Color', vehicle.vehicleColor,
//                       Icons.palette_outlined),
//                   _detailRow('Wheel Type', vehicle.wheelType,
//                       Icons.tire_repair_outlined),
//                   _detailRow('Manufacturing Year', vehicle.manufacturingYear,
//                       Icons.calendar_today_outlined),

//                   // ✅ Show image URL row only if not empty
//                   if (vehicle.vehicleImage.isNotEmpty)
//                     _detailRow(
//                         'Image', vehicle.vehicleImage, Icons.image_outlined),

//                   const SizedBox(height: 30),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: OutlinedButton.icon(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(
//                             color: AppColors.primaryBlue, width: 1.5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                           size: 16, color: AppColors.primaryBlue),
//                       label: const Text(
//                         'Back to Fleet',
//                         style: TextStyle(
//                           color: AppColors.primaryBlue,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Properly handles network image, local file fallback, placeholder
//   Widget _buildHeroImage() {
//     if (vehicle.vehicleImage.isNotEmpty) {
//       return Image.network(
//         vehicle.vehicleImage,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return Container(
//             color: AppColors.darkBlue,
//             child: const Center(
//               child: CircularProgressIndicator(
//                   color: Colors.white54, strokeWidth: 2),
//             ),
//           );
//         },
//         errorBuilder: (_, __, ___) => _imagePlaceholder(),
//       );
//     }
//     return _imagePlaceholder();
//   }

//   Widget _imagePlaceholder() {
//     return Container(
//       color: AppColors.darkBlue,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.directions_car,
//               size: 80, color: Colors.white24),
//           const SizedBox(height: 8),
//           Text(
//             'No image available',
//             style: TextStyle(
//                 color: Colors.white.withOpacity(0.3), fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _badge(String text, Color color, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.85),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 11, color: Colors.white),
//           const SizedBox(width: 4),
//           Text(
//             text,
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 11,
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _specCard({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Icon(icon, color: color, size: 22),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label,
//                   style: TextStyle(
//                       fontSize: 11,
//                       color: color.withOpacity(0.8),
//                       fontWeight: FontWeight.w500)),
//               Text(
//                 value.isEmpty ? '—' : value,
//                 style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textDark),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _detailRow(String label, String value, IconData icon) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
//       decoration: BoxDecoration(
//         color: AppColors.creamGrey,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: AppColors.primaryBlue),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: const TextStyle(
//                         fontSize: 11, color: AppColors.textMuted)),
//                 Text(
//                   value.isEmpty ? '—' : value,
//                   style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textDark),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }import 'package:drivelist/core/appcolors.dart';
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
            // ── Image Section ──
            _buildImageSection(),

            // ── Content ──
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

                  // ── Spec Grid ──
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