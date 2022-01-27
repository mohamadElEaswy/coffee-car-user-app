import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mk/src/core/assets/assets.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
// import 'package:mk/src/core/navigation/navigation_methods.dart';
// import 'package:mk/src/ui/pages/cart/cart_page.dart';
// import 'package:mk/src/ui/pages/profile/profile_page.dart';
// import 'package:mk/src/ui/theme/theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/locations.dart' as locations;

const double contentPadding = 8.0;

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  static const String route = '/home';

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  void onPressed() {}
  late GoogleMapController mapController;
  final Map<String, Marker> markers = {};
  final LatLng center = const LatLng(45.521563, -122.677433);

  Future<void> onMapCreated(GoogleMapController controller) async{
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
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
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AppCubit bloc = AppCubit.get(context);
        return Scaffold(
          drawer: Column(
            children: const [Text('ss')],
          ),
          body: buildBody(bloc: bloc),
        );
      },
    );
  }

  Widget buildBody({required AppCubit bloc}) {
    return SafeArea(
      child: Stack(
        children: [
          buildMap(),
          customHeader(),
          customDraggable(context: context),
        ],
      ),
    );
  }
  Widget buildMap() => Container(
    height: 600,
    color: Colors.cyan[100],
    child: Center(
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 11.0,
        ),markers: markers.values.toSet(),
      ),
    ),
  );
  Widget customHeader() => Container(
    height: 50,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Row(
      children: const [
        Padding(
          padding: EdgeInsets.all(4),
          child: CircleAvatar(backgroundColor: Colors.cyan),
        ),
      ],
    ),
  );

  Widget customDraggable({required BuildContext context}) => DraggableScrollableSheet(
    initialChildSize: 0.30,
    minChildSize: 0.15,
    builder: (BuildContext context, ScrollController scrollController) {
      return Container(
        color: Colors.white,
        child: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) => Text('$index'),
          itemCount: 100,
          padding: const EdgeInsets.all(10),
        ),
      );
    },
  );
}




