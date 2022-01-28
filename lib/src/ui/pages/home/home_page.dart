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
import 'package:mk/src/locations.dart';
// import 'package:mk/src/locations.dart';
// import 'package:mk/src/locations.dart' as locations;

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
  // late GoogleMapController mapController;
  // final Map<String, Marker> markers = {};
  // final LatLng center = const LatLng(45.521563, -122.677433);
  //
  // Future<void> onMapCreated(GoogleMapController controller) async{
  //   final googleOffices = await locations.getGoogleOffices();
  //   setState(() {
  //     markers.clear();
  //     for (final office in googleOffices.offices) {
  //       final marker = Marker(
  //         markerId: MarkerId(office.name),
  //         position: LatLng(office.lat, office.lng),
  //         infoWindow: InfoWindow(
  //           title: office.name,
  //           snippet: office.address,
  //         ),
  //       );
  //       markers[office.name] = marker;
  //     }
  //   });
  // }
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
          body: bloc.body[bloc.currentIndex],
          // buildBody(bloc: bloc),
          // cubit.body[cubit.currentIndex],
          bottomNavigationBar: SizedBox(
            height: 60,
            child: BottomNavigationBar(
              // enableFeedback: true,
              backgroundColor: Colors.grey,
              selectedItemColor: Colors.cyan,
              unselectedItemColor: Colors.grey,
              items: bloc.items,
              onTap: (int index) {
                bloc.changeScreen(index: index);
              },
              elevation: 0.0,
              currentIndex: bloc.currentIndex,
            ),
          ),
        );
      },
    );
  }
}

class HomeBodyPage extends StatelessWidget {
  const HomeBodyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit bloc = AppCubit.get(context);
        return SafeArea(
          child: Stack(
            children: [
              buildMap(bloc: bloc),
              customHeader(),
              // customDraggable(context: context),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextButton(onPressed: (){},
                          child: const Text('View list', style: TextStyle(color: Colors.black)),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white))),
                    ),
                    SizedBox(
                      height: 175,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return cardItem(item: bloc.data[index], context: context);
                        },
                        itemCount: bloc.data.length,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget cardItem({required Office item, required BuildContext context}) =>Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)),
    margin: const EdgeInsets.only(right: 10, left: 5),
    child: Container(
      padding: const EdgeInsets.all(20),
      width: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name),
          Container(
            padding: const EdgeInsets.only(
                right: 10, left: 10, top: 5, bottom: 5),
            margin:
            const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xfffA9927D),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.white,
                ),
                Text('4.0',
                    style: TextStyle(color: Colors.white, fontSize: 10))
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.not_listed_location_outlined,
                size: 15,
                // color: Colors.white,
              ),const SizedBox(width: 10),
              Text(item.region, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(),),
              const Spacer(),
              Icon(Icons.watch_later)
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.watch_later_rounded,
                size: 15,
                // color: Colors.white,
              ),const SizedBox(width: 10),
              Text('Open 24 hors', maxLines: 1, style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ],
      ),
    ),
  );
  Widget buildMap({required AppCubit bloc}) => Container(
        color: Colors.cyan[100],
        child: Center(
          child: GoogleMap(
            // myLocationButtonEnabled: true,
            onMapCreated: bloc.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: bloc.center,
              zoom: 11.0,
            ),
            markers: bloc.markers.values.toSet(),
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

  Widget customDraggable({required BuildContext context}) =>
      DraggableScrollableSheet(
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
