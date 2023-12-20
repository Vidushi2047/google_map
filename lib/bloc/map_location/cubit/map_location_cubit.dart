import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/model/item_model.dart';

part 'map_location_state.dart';

class MapLocationCubit extends Cubit<MapLocationState> {
  MapLocationCubit() : super(MapLocationState.initial());

  void addLocation(Item item) {
    var itemList = [...state.locationItemList];
    print(itemList);
    var itemIndex = itemList.indexWhere((element) => element.id == item.id);
    if (itemIndex != -1) {
      print('already add');
    } else {
      itemList.add(Item(name: item.name, latLng: item.latLng, id: item.id));
    }

    emit(state.copyWith(locationItemList: itemList));
    print(itemList);
  }

  // void delete(Item item) {
  //   var itemList = [...state.locationItemList];
  //   itemList.removeWhere((element) => element.id == item.id);
  //   print(itemList);
  //   emit(state.copyWith(locationItemList: itemList));
  // }
  void deleteItem(index) {
    final state = this.state;
    var itemList = [...state.locationItemList];
    itemList.removeAt(index);
    emit(state.copyWith(locationItemList: itemList));
  }
}
