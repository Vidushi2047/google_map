part of 'map_cubit.dart';

class MapState extends Equatable {
  double lat;
  double long;
  MapState({
    required this.lat,
    required this.long,
  });
  factory MapState.initial() {
    return MapState(lat: 0, long: 0);
  }
  MapState copyWith({
    double? lat,
    double? long,
  }) {
    return MapState(
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  @override
  String toString() => 'MapState(lat: $lat, long: $long)';

  @override
  List<Object?> get props => [lat, long];
}
