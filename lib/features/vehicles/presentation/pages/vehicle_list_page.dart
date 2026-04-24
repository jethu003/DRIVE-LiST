import 'package:drivelist/core/appcolors.dart';
import 'package:drivelist/features/vehicles/presentation/pages/add_vehicle_page.dart';
import 'package:flutter/material.dart';

class VehicleListPage extends StatelessWidget {
  const VehicleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicles = [
      {
        "model": "Swift",
        "color": "Red",
        "year": "2022",
        "wheelType": "Alloy Wheels",
        "image": "https://picsum.photos/200"
      },
      {
        "model": "Creta",
        "color": "White",
        "year": "2023",
        "wheelType": "Steel Wheels",
        "image": "https://picsum.photos/200"
      },
      {
        "model": "Polo",
        "color": "Blue",
        "year": "2021",
        "wheelType": "Performance Wheels",
        "image": "https://picsum.photos/200"
      },
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddVehicleSheet(),
    );
      },
      backgroundColor: AppColors.primaryBlue,
      child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.creamGrey,
        title: const Text('DRIVE LIST'),
      ),
      backgroundColor: AppColors.creamWhite,

      body: ListView.builder(
        itemCount: vehicles.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];

          return Card(
            color: AppColors.creamGrey,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),

              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  vehicle["image"]!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),

              title: Text(
                vehicle["model"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Color: ${vehicle["color"]}"),
                  Text("Year: ${vehicle["year"]}"),
                  Text("Wheel: ${vehicle["wheelType"]}"),
                ],
              ),

              trailing: const Icon(Icons.arrow_forward_ios, size: 16),

              onTap: () {
                // later: navigate to detail page
              },
            ),
          );
        },
      ),
    );
  }
}