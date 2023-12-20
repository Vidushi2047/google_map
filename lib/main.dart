import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/bloc/mapLocation/cubit/map_cubit.dart';
import 'package:location_tracker/bloc/map_location/cubit/map_location_cubit.dart';
import 'package:location_tracker/bloc/marker/cubit/marker_cubit.dart';
import 'package:location_tracker/screen/cluster%20marker.dart';
import 'package:location_tracker/widget/appBlocObserver.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapCubit()..getLocation(),
        ),
        BlocProvider(
          create: (context) => MapLocationCubit(),
        ),
        BlocProvider(create: (context) {
          final mapCubitState = context.read<MapCubit>().state;
          return MarkerCubit(LatLng(mapCubitState.lat, mapCubitState.long));
        }),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen1(),
      ),
    );
  }
}
