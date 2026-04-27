class VehicleModel {
  final String id; // Firestore document ID
  final String vehicleImage;
  final String vehicleModel;
  final String vehicleColor;
  final String wheelType;
  final String manufacturingYear;

  VehicleModel({
    this.id = '',
    required this.vehicleImage,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.wheelType,
    required this.manufacturingYear,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json, {String id = ''}) {
    return VehicleModel(
      id: id,
      vehicleImage: json['vehicleImage'] ?? '',
      vehicleModel: json['vehicleModel'] ?? '',
      vehicleColor: json['vehicleColor'] ?? '',
      wheelType: json['wheelType'] ?? '',
      manufacturingYear: json['manufacturingYear'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleImage': vehicleImage,
      'vehicleModel': vehicleModel,
      'vehicleColor': vehicleColor,
      'wheelType': wheelType,
      'manufacturingYear': manufacturingYear,
    };
  }
}