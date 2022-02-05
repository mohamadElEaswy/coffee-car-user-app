import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/locations.dart';
import 'package:provider/provider.dart';

import '../../../services/remote/internet_connection_status/network_status_service.dart';
import '../../colors/static_colors.dart';
import '../check_internet/network_aware_widget.dart';
import '../providers/providers_page.dart';
import '../sign_in_with_email/sign_in_with_email_screen.dart';

const double contentPadding = 8.0;

//using this class to check the internet connection and to show the different screens(no internet or the app)
class InternetCheck extends StatelessWidget {
  const InternetCheck({Key? key}) : super(key: key);
  static const String route = 'check';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<NetworkStatus>(
        initialData: NetworkStatus.offline,
        create: (context) =>
            NetworkStatusService().networkStatusController.stream,
        child: const NetworkAwareWidget(
          offlineChild: Scaffold(
            body: Center(child: Text('No internet connection')),
          ),
          onlineChild: Home(title: 'title'),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  static const String route = '/home';

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  void onPressed() {}
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AppCubit bloc = AppCubit.get(context);
        return SafeArea(
          bottom: true,
          top: true,
          child: Scaffold(
            drawer: Column(
              children: const [Text('ss')],
            ),
            body: bloc.body[bloc.currentIndex],
            // buildBody(bloc: bloc),
            // cubit.body[cubit.currentIndex],
            bottomNavigationBar: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                // enableFeedback: true,
                // backgroundColor: Colors.grey,
                selectedItemColor: GlobalStaticColors.debBlue,
                unselectedItemColor: Colors.grey,
                items: bloc.items,
                onTap: (int index) {
                  if (bloc.auth.currentUser != null) {
                    RouteMethods.navigateTo(
                        context: context, routeName: SignInWithEmail.route);
                  } else {
                    bloc.changeScreen(index: index);
                  }
                },
                elevation: 0.0,
                currentIndex: bloc.currentIndex,
              ),
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
        //to enable my current location into the home map
        bloc.myLocation();
        return SafeArea(
          top: true,
          bottom: true,
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
                      child: TextButton(
                          onPressed: () {
                            RouteMethods.navigateTo(
                              context: context,
                              routeName: ProvidersPage.route,
                            );
                          },
                          child: const Text('View list',
                              style: TextStyle(color: Colors.black)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                    ),
                    SizedBox(
                      height: 175,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return cardItem(
                              bloc: bloc,
                              item: bloc.data[index],
                              context: context);
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

  Widget cardItem(
          {required Office item,
          required BuildContext context,
          required AppCubit bloc}) =>
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        margin: const EdgeInsets.only(right: 10, left: 5),
        child: InkWell(
          onTap: () {
            bloc.changeMapView(latitude: item.lat, longitude: item.lng);
          },
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
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.region,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(),
                    ),
                    const Spacer(),
                    const Icon(Icons.watch_later)
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
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Open 24 hors',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  Widget buildMap({required AppCubit bloc}) => Container(
        color: Colors.cyan[100],
        child: Center(
          child: GoogleMap(
            // myLocationButtonEnabled: true,
            onMapCreated: bloc.onMapCreated,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: bloc.center,
              zoom: 11.0,
            ),
            cameraTargetBounds: CameraTargetBounds.unbounded,
            markers: bloc.markers.values.toSet(),
            myLocationButtonEnabled: true,
            myLocationEnabled: true, compassEnabled: true,
            mapToolbarEnabled: true,
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

  // Widget customDraggable({required BuildContext context}) =>
  //     DraggableScrollableSheet(
  //       initialChildSize: 0.30,
  //       minChildSize: 0.15,
  //       builder: (BuildContext context, ScrollController scrollController) {
  //         return Container(
  //           color: Colors.white,
  //           child: ListView.builder(
  //             controller: scrollController,
  //             itemBuilder: (context, index) => Text('$index'),
  //             itemCount: 100,
  //             padding: const EdgeInsets.all(10),
  //           ),
  //         );
  //       },
  //     );
}
