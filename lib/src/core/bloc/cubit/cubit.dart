// ignore_for_file: avoid_print
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/locations.dart' as locations;
import 'package:mk/src/services/remote/firebase/auth.dart';
import 'package:mk/src/ui/pages/cart/cart_page.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/likes_page/likes_page.dart';
import 'package:mk/src/ui/pages/notifications/notifications_page.dart';
import 'package:mk/src/ui/pages/profile/profile_page.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

//get home map data methods
  //this var to create controller to change the view with the map in the home
  GoogleMapController? mapController;

  final Map<String, Marker> markers = {};
  LatLng center = const LatLng(30.0444, 31.2357);

  List<locations.Office> data = [];
  Future<void> onMapCreated(GoogleMapController controller) async {
    emit(LoadingMapsState());
    final googleOffices = await locations.getGoogleOffices();

    mapController = controller;

    data = googleOffices.offices;

    markers.clear();
    for (final office in googleOffices.offices) {
      final marker = Marker(
        visible: true,
        markerId: MarkerId(office.name),
        position: LatLng(office.lat, office.lng),
        infoWindow: InfoWindow(
          title: office.name,
          snippet: office.address,
        ),
        // icon: BitmapDescriptor,
      );
      markers[office.name] = marker;
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
    // const Home(title: 'Coffee car',),
    const HomeBodyPage(),
    const Cart(),
    const LikesPage(),
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
  Future<void> myLocationButton() async {
    return await mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(current.latitude!, current.longitude!), zoom: 17)));
  }

  AuthBase auth = Auth();
  // void signIn({required String email,required String password}) async{
  //   await auth.signInWithEmailAndPassword(email, password);
  // }
}
