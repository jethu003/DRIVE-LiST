import 'package:cloud_firestore/cloud_firestore.dart';
import 'vehicle_model.dart';

class VehicleData {
  final _collection = FirebaseFirestore.instance.collection('vehicles');

  Stream<List<VehicleModel>> getVehiclesStream() {
    return _collection
        .orderBy('manufacturingYear', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => VehicleModel.fromJson(doc.data(), id: doc.id))
            .toList());
  }

  Future<void> addVehicle(VehicleModel model) async {
    try {
      await _collection.add(model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteVehicle(String id) async {
    await _collection.doc(id).delete();
  }
}