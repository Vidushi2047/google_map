// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'marker_cubit.dart';

abstract class MarkerState extends Equatable {}

class MarkerState1 extends MarkerState {
  String name;
  LatLng latLng;
  int index;
  MarkerState1({
    required this.name,
    required this.latLng,
    required this.index,
  });
  factory MarkerState1.initial(LatLng latLng) {
    return MarkerState1(name: 'Current State', latLng: latLng, index: 0);
  }
  @override
  List<Object?> get props => [name, latLng, index];

  MarkerState1 copyWith({
    String? name,
    LatLng? latLng,
    int? index,
  }) {
    return MarkerState1(
      name: name ?? this.name,
      latLng: latLng ?? this.latLng,
      index: index ?? this.index,
    );
  }

  @override
  String toString() =>
      'MarkerState1(name: $name, latLng: $latLng, index: $index)';
}

class CustomMarkerState extends MarkerState {
  bool isClickMarker;
  CustomMarkerState({
    required this.isClickMarker,
  });
  factory CustomMarkerState.initial() {
    return CustomMarkerState(isClickMarker: false);
  }
  @override
  List<Object?> get props => [isClickMarker];

  @override
  String toString() => 'CustomMarkerState(isClickMarker: $isClickMarker)';

  CustomMarkerState copyWith({
    bool? isClickMarker,
  }) {
    return CustomMarkerState(
      isClickMarker: isClickMarker ?? this.isClickMarker,
    );
  }
}


// class MarkerState extends Equatable {
//   String name;
//   LatLng latLng;
//   int index;
//   MarkerState({
//     required this.name,
//     required this.latLng,
//     required this.index,
//   });
//   factory MarkerState.initial() {
//     return MarkerState(
//         name: 'Current Location', latLng: LatLng(0, 0), index: 0);
//   }
//   // MarkerState copyWith({
//   //   String? name,
//   //   LatLng? latLng,
//   //   int? index,
//   // }) {
//   //   return MarkerState(
//   //     name: name ?? this.name,
//   //     latLng: latLng ?? this.latLng,
//   //     index: index ?? this.index,
//   //   );
//   // }

//   @override
//   String toString() =>
//       'MarkerState(name: $name, latLng: $latLng, index: $index)';

//   @override
//   // TODO: implement props
//   List<Object?> get props => [name, latLng, index];
// }
