// ignore_for_file: public_member_api_docs, sort_constructors_first
class PositionModel {
  double latitude;
  double longitude;
  
  PositionModel({
    required this.latitude,
    required this.longitude,
  });

  PositionModel copyWith({
    double? latitude,
    double? longitude,
  }) {
    return PositionModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  bool operator ==(covariant PositionModel other) {
    if (identical(this, other)) return true;
    return other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
