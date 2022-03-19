// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:mk/src/core/assets/assets.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/locations.dart' as locations;
import 'package:mk/src/services/remote/firebase/auth.dart';
import 'package:mk/src/ui/pages/cart/cart_page.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/likes_page/likes_page.dart';
import 'package:mk/src/ui/pages/notifications/notifications_page.dart';
import 'package:mk/src/ui/pages/profile/profile_page.dart';

import '../../../locations.dart';
import '../../../services/remote/firebase/database.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);
  Database database = FirestoreDatabase();
//get home map data methods
  //this var to create controller to change the view with the map in the home
  GoogleMapController? mapController;

  final Map<String, Marker> markers = {};
  LatLng center = const LatLng(30.0444, 31.2357);

  List<Cars> data = [];

  Future<void> onMapCreated(GoogleMapController controller) async {
    emit(LoadingMapsState());
    data.clear();
    await database.getLocationsList().then(
      (List<Cars> value) {
        print(value.length);
        data.addAll(value);
        print(data.length);
      },
    );
    // final carsList = await locations.getGoogleOffices();

    mapController = controller;

    // data = googleOffices.offices;

    markers.clear();
    for (final car in data) {
      final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(30, 30), devicePixelRatio: 2.5),
        AppAssets.carIcon,
      );
      final marker = Marker(
        visible: true,
        markerId: MarkerId(car.name),
        position: LatLng(car.lat, car.lng),
        infoWindow: const InfoWindow(
          title: 'car name',
          snippet: 'car address',
        ),
        icon: icon,
      );
      markers[car.name] = marker;
    }
    emit(SuccessMapsState());
  }

//this method is to change the map view in the home
  Future<void> changeMapView(
      {required double latitude, required double longitude}) async {
    return await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 17),
      ),
    );
  }

/*manage bottom navigation bar*/
  int currentIndex = 0;
  List<Widget> body = [
    const HomeBodyPage(),
    const LikesPage(),
    const Cart(),
    const NotificationsPage(),
    const Profile(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.home), label: 'Home', tooltip: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.objectGroup),
        label: 'Providers',
        tooltip: 'Providers'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), label: 'Cart', tooltip: 'Cart'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorites', tooltip: 'Favorites'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Profile', tooltip: 'Profile'),
  ];

  void changeScreen({required int index}) {
    currentIndex = index;
    emit(ChangeScreenState());
  }
  //end bottom navigation bar

  //this method is to enable my current location into the home map.
  Location location = Location();
  late LocationData current;
  Future<LocationData> myLocation() async {
    current = await location.getLocation();
    return current;
  }

  //my location button in home screen
  //firstly check if location services permission is granted(true, or false) and ask the permission if it is not granted
  Future<void> myLocationButton() async {
    if (await location.serviceEnabled()) {
      return await mapController!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(current.latitude!, current.longitude!),
        zoom: 17,
      )));
    } else {
      location.requestService();
    }
  }

  AuthBase auth = Auth();
  // User? currentUser;
  // List cars =[];
  // Database database = FirestoreDatabase();
  // void tryDB(){
  //   print(database.carsStream().toString());
  // }

  // void signIn({required String email,required String password}) async{
  //   await auth.signInWithEmailAndPassword(email, password);
  // }
}
