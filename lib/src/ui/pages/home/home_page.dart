import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/ui/widgets/loading_widget.dart';
import '../../../locations.dart';
import '../../colors/static_colors.dart';
import '../check_internet/internet_states.dart';
import '../providers/providers_page.dart';
import '../sign_in_with_email/sign_in_with_email_screen.dart';
import 'home_card.dart';
import 'home_header.dart';
import 'home_map.dart';

const double contentPadding = 8.0;

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  static const String route = '/home';
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AppCubit bloc = AppCubit.get(context);
        final User? currentUser = bloc.auth.currentUser;
        // final Database database = Provider.of<FirestoreDatabase>(context, listen: false);
        // database.getUser(currentUser!.uid);
        return InternetCheck(
          online: SafeArea(
            bottom: true,
            top: true,
            child: Scaffold(
              drawerScrimColor: Colors.black38,
              key: scaffoldKey,
              drawer: Drawer(
                child: Column(
                  children: const [Text('ss')],
                ),
              ),
              body: bloc.body[bloc.currentIndex],
              bottomNavigationBar: SizedBox(
                height: 60,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: GlobalStaticColors.deepBlue,
                  unselectedItemColor: Colors.grey,
                  items: bloc.items,
                  onTap: (int index) {
                    // print();

                    if (currentUser == null && index > 0) {
                      RouteMethods.navigateTo(
                          context: context,
                          routeName: SignInWithEmailAndPhone.route);
                    } else if (index == 0) {
                      bloc.changeScreen(index: index);
                    } else {
                      bloc.changeScreen(index: index);
                    }
                  },
                  elevation: 0.0,
                  currentIndex: bloc.currentIndex,
                ),
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
    final double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit bloc = AppCubit.get(context);
        //to enable my current location into the home map

        return SafeArea(
          top: true,
          bottom: true,
          child: Stack(
            children: [
              HomeMap(bloc: bloc),
              HomeHeader(width: width),
              // customDraggable(context: context),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
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
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: FloatingActionButton(
                            onPressed: bloc.myLocationButton,
                            child: const Icon(FontAwesomeIcons.locationArrow),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 175,
                      child: FutureBuilder(
                          future: bloc.database.getLocationsList(),
                          builder: (BuildContext context,
                                  AsyncSnapshot<List<Cars>> snapshot) =>
                              snapshot.data != null
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => HomeCard(
                                        car: snapshot.data![index],
                                        bloc: bloc,
                                        context: context,
                                      ),
                                      itemCount: snapshot.data!.length,
                                      padding: const EdgeInsets.all(15),
                                    )
                                  : const GlobalLoading()),
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
