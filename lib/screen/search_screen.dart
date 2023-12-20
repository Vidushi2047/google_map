import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/bloc/map_location/cubit/map_location_cubit.dart';
import 'package:location_tracker/bloc/marker/cubit/marker_cubit.dart';
import 'package:location_tracker/model/item_model.dart';
import 'package:location_tracker/screen/cluster%20marker.dart';
import 'package:location_tracker/utils/marker_info.dart';
import 'package:advanced_search/advanced_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int n = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Location'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<MapLocationCubit, MapLocationState>(
            listener: (context, state) {},
            builder: (con, state) {
              return BlocConsumer<MarkerCubit, MarkerState>(
                listener: (co, st) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Container(
                    margin:
                        const EdgeInsets.only(top: 30.0, left: 30, right: 30),
                    child: AdvancedSearch(
                      searchItems: locationName,
                      maxElementsToDisplay: 10,
                      singleItemHeight: 50,
                      borderColor: Colors.grey,
                      minLettersForSearch: 0,
                      selectedTextColor: const Color(0xFF3363D9),
                      fontSize: 14,
                      borderRadius: 12.0,
                      hintText: 'Search Place',
                      cursorColor: Colors.blueGrey,
                      autoCorrect: false,
                      focusedBorderColor: Colors.blue,
                      searchResultsBgColor: const Color(0xffFAFAFA),
                      disabledBorderColor: Colors.cyan,
                      enabledBorderColor: Colors.black,
                      enabled: true,
                      caseSensitive: false,
                      inputTextFieldBgColor: Colors.white10,
                      clearSearchEnabled: true,
                      itemsShownAtStart: 10,
                      searchMode: SearchMode.CONTAINS,
                      showListOfResults: true,
                      unSelectedTextColor: Colors.black54,
                      verticalPadding: 10,
                      horizontalPadding: 10,
                      hideHintOnTextInputFocus: true,
                      hintTextColor: Colors.grey,
                      searchItemsWidget: searchWidget,
                      onItemTap: (index, value) {
                        print("selected item Index is $index");
                        setState(() {
                          n = index;
                        });
                      },
                      onSearchClear: () {
                        print("Cleared Search");
                      },
                      onSubmitted: (value, value2) {
                        print("Submitted: " + value);

                        BlocProvider.of<MapLocationCubit>(con, listen: false)
                            .addLocation(Item(
                                id: n + 1,
                                name: locationName[n],
                                latLng: markerLocations[n]));
                        setState(() {
                          isClickMarker = false;
                        });
                        Navigator.pop(
                          context,
                        );
                        locate(markerLocations[n], n + 1);

                        con.read<MarkerCubit>().custormarkerValue(
                            locationName[n], markerLocations[n], n + 1);
                        print("LENGTH: " + value2.length.toString());
                      },
                      onEditingProgress: (value, value2) {
                        print("TextEdited: " + value);
                        print("LENGTH: " + value2.length.toString());
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget searchWidget(String text) {
    return ListTile(
      title: Text(
        text.length > 3 ? text.substring(0, 3) : text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.indigoAccent),
      ),
      subtitle: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          color: Colors.black26,
        ),
      ),
    );
  }
}
