class CoordonneeModel {
  final double latitude;
  final double longitude;
  final double altitude;

  CoordonneeModel({
    required this.latitude,
    required this.longitude,
    required this.altitude,
  });
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
      };
  static CoordonneeModel fromData(Map<String, dynamic> data) => CoordonneeModel(
        latitude: data['latitude'],
        longitude: data['longitude'],
        altitude: data['altitude'],
      );
}
