// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'marker_state.dart';

class MarkerCubit extends Cubit<MarkerState> {
  late LatLng latLng;
  MarkerCubit(
    this.latLng,
  ) : super(MarkerState1.initial(latLng));

  void custormarkerValue(String name, LatLng latLng, index) {
    try {
      print('before state----$state');

      emit(MarkerState1(name: name, latLng: latLng, index: index));
      print('after state----$state');
    } catch (e) {
      print('error-$e');
    }
  }

  void customMarkerChange() {
    emit(CustomMarkerState(isClickMarker: true));
  }

  void customMarkerUnchange() {
    emit(CustomMarkerState(isClickMarker: false));
  }
}
