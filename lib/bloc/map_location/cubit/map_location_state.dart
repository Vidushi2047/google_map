// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_location_cubit.dart';

class MapLocationState extends Equatable {
  List<Item> locationItemList;
  MapLocationState(this.locationItemList);
  factory MapLocationState.initial() {
    return MapLocationState([
      Item(
        id: 0,
        name: 'Current Location',
        latLng: const LatLng(28.58000, 77.33000),
      )
    ]);
  }

  MapLocationState copyWith({
    List<Item>? locationItemList,
  }) {
    return MapLocationState(
      locationItemList ?? this.locationItemList,
    );
  }

  @override
  String toString() => 'MapLocationState(locationItemList: $locationItemList)';

  @override
  List<Object?> get props => [locationItemList];
}
