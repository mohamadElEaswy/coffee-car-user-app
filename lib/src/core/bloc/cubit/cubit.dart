// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/assets/assets.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/locations.dart' as locations;
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

    // setState(() {
    markers.clear();
    for (final office in googleOffices.offices) {
      final marker = Marker(
        markerId: MarkerId(office.name),
        position: LatLng(office.lat, office.lng),
        infoWindow: InfoWindow(
          title: office.name,
          snippet: office.address,
        ),
      );
      markers[office.name] = marker;
    }
    emit(SuccessMapsState());
    // });
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
    BottomNavigationBarItem(
        icon: Image.asset(AppAssets.homeLogo),
        activeIcon: Image.asset(AppAssets.darkHomeLogo),
        label: '',
        tooltip: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.category), label: '_'),
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '_'),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '_'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: '_'),
  ];

  void changeScreen({required int index}) {
    currentIndex = index;
    emit(ChangeScreenState());
  }

  //end bottom navigation bar
  void hello(String h) {
    print(h);
  }
}
