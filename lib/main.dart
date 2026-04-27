import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/vehicles/presentation/pages/vehicle_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ✅ Must be GetMaterialApp, NOT MaterialApp
      title: 'Drive List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const VehicleListPage(),
    );
  }
}