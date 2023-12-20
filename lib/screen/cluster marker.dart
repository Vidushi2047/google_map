import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/bloc/mapLocation/cubit/map_cubit.dart';
import 'package:location_tracker/bloc/map_location/cubit/map_location_cubit.dart';
import 'package:location_tracker/bloc/marker/cubit/marker_cubit.dart';
import 'package:location_tracker/screen/search_screen.dart';
import 'package:location_tracker/utils/marker_info.dart';

late GoogleMapController mapController;
void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
  print('controller-$controller');
}

bool isClickMarker = false;

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key, this.mLocation, this.mName, this.mId})
      : super(key: key);
  final String? mName;
  final LatLng? mLocation;
  final int? mId;

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  LatLng center = const LatLng(28.58000000, 77.33000000);
  String name = 'Current Location';

  LatLng location = const LatLng(28.58000000, 77.33000000);

  int ind = 0;
  Map<MarkerId, Marker> marker = {};

  Set<Marker> markers = {};
  List<bool> isSelectedList = [];

  addMarker() async {
    for (int i = 0; i < markerLocations.length; i++) {
      LatLng location = markerLocations[i];
      MarkerId id = MarkerId(i.toString());
      // BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      //   const ImageConfiguration(size: Size(10, 10)),
      //   "assets/images/th.jpg",
      // );
      Marker marker = Marker(
          markerId: id,
          position: location,
          // icon: markerIcon,
          infoWindow: InfoWindow(
            title: locationName[i],
            snippet: "${markerLocations[i]}",
          ),
          onTap: () {
            setState(() {
              isClickMarker = true;
            });
            print('marker');
          });
      markers.add(
        marker,
      );
    }
    setState(() {});
  }
  // List<Marker> markers = [
  //   for (int i = 0; i < markerLocations.length; i++)
  //     Marker(
  //       markerId: MarkerId(i.toString()),
  //       position: markerLocations[i],
  //     ),
  // ];

  @override
  void initState() {
    isSelectedList = List.generate(markerLocations.length, (index) => false);
    addMarker();
    isClickMarker = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('build');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 244, 236),
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Find Location'),
        actions: [
          IconButton(
              onPressed: () {
                print('screen');
              },
              icon: const Icon(Icons.location_on))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            print('1');
            return BlocBuilder<MapLocationCubit, MapLocationState>(
                builder: (cont, sta) {
              print('2');
              var locationList = sta.locationItemList;
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height / 2,
                        width: size.width,
                        child: Stack(
                          children: [
                            GoogleMap(
                              zoomControlsEnabled: true,
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                  target: center, zoom: 13, tilt: 3),
                              markers: Set.from(markers),
                              onTap: (LatLng latLng) {
                                print('latlong----$latLng');
                              },

                              // onCameraMove: (CameraPosition position) {
                              //   if (position.zoom < 10) {
                              //     LatLng averageLatLng =
                              //         calculateAverageLatLng(markers);
                              //     setState(() {
                              //       markers.clear();
                              //       print(markers);
                              //       markers.add(
                              //         Marker(
                              //           markerId: MarkerId('index'),
                              //           position: averageLatLng,
                              //         ),
                              //       );
                              //       print(markers);
                              //     });
                              //   }
                              // },
                            ),
                            isClickMarker
                                ? Text('')
                                : BlocBuilder<MarkerCubit, MarkerState>(
                                    builder: (context, state1) {
                                      if (state1 is MarkerState1) {
                                        return Positioned(
                                            bottom: size.height / 3 - 30,
                                            left: size.width / 3,
                                            child: Container(
                                              width: size.width / 3,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Image(
                                                      image: AssetImage(
                                                          "assets/images/th.jpg")),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    child: Column(
                                                      children: [
                                                        Text(state1.name),
                                                        Text(state1.latLng
                                                            .toString()),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                                      }
                                      return Center(
                                        child: Text('ceter'),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Find Your Location',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SearchScreen();
                          }));
                        },
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  Container(
                      height: size.height / 2 - 150,
                      width: size.width,
                      child: ListView(
                        children: List.generate(
                            locationList.length,
                            (index) => locationList.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      print('update');
                                      setState(() {
                                        isClickMarker = false;
                                        ind = index;
                                        name = locationList[ind].name;
                                        location = locationList[ind].latLng;
                                        print('index-$ind');
                                        isSelectedList.replaceRange(
                                            0, isSelectedList.length, [
                                          for (int i = 0;
                                              i < isSelectedList.length;
                                              i++)
                                            false
                                        ]);
                                        isSelectedList[ind] = true;
                                        LatLng newlatlang =
                                            LatLng(state.lat, state.long);
                                        try {
                                          newlatlang = locationList[ind].latLng;

                                          print(newlatlang);
                                          locate(newlatlang, ind);
                                          context
                                              .read<MarkerCubit>()
                                              .custormarkerValue(
                                                  locationList[ind].name,
                                                  locationList[ind].latLng,
                                                  ind);
                                        } catch (e) {
                                          print('error-$e');
                                        }
                                      });
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: isSelectedList[index]
                                              ? Colors.green.shade300
                                              : Colors.green.shade100,
                                        ),
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(locationList[index].name),
                                            if (index != 0)
                                              IconButton(
                                                  onPressed: () {},
                                                  icon:
                                                      const Icon(Icons.delete))
                                          ],
                                        )))
                                : const Center(
                                    child: Text('Current Location'),
                                  )),
                      )),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}

List<Marker> markers = [
  for (int i = 0; i < markerLocations.length; i++)
    Marker(
      markerId: MarkerId(i.toString()),
      position: markerLocations[i],
    ),
];

LatLng calculateAverageLatLng(List<Marker> markers) {
  double sumLat = 0.0;
  double sumLng = 0.0;

  for (var marker in markers) {
    sumLat += marker.position.latitude;
    sumLng += marker.position.longitude;
  }

  double avgLat = sumLat / markers.length;
  double avgLng = sumLng / markers.length;

  return LatLng(avgLat, avgLng);
}

locate(LatLng latLng, index) {
  try {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 10)));
    // mapController.showMarkerInfoWindow(MarkerId(index.toString()));
    mapController.hideMarkerInfoWindow(MarkerId(index.toString()));

    print('locate');
    print(latLng);
  } catch (e) {
    print('error-$e');
  }
}
