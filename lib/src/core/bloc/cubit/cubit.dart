// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/locations.dart' as locations;
import 'package:mk/src/ui/pages/cart/cart_page.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/likes_page/likes_page.dart';
import 'package:mk/src/ui/pages/notifications/notifications_page.dart';
import 'package:mk/src/ui/pages/profile/profile_page.dart';
class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

//get home map data methods
  late GoogleMapController mapController;
  final Map<String, Marker> markers = {};
  final LatLng center = const LatLng(30.0444, 31.2357);
  List<locations.Office> data =[];
  Future<void> onMapCreated(GoogleMapController controller) async{
    emit(LoadingMapsState());
    final googleOffices = await locations.getGoogleOffices();

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
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'setting',
    ),
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