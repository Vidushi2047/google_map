// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Item {
  int id;
  String name;
  LatLng latLng;
  Item({
    required this.id,
    required this.name,
    required this.latLng,
  });

  Item copyWith({
    int? id,
    String? name,
    LatLng? latLng,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      latLng: latLng ?? this.latLng,
    );
  }
}
