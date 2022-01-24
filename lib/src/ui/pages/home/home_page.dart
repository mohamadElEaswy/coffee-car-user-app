import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/assets/assets.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/ui/pages/cart/cart_page.dart';
import 'package:mk/src/ui/pages/profile/profile_page.dart';
import 'package:mk/src/ui/theme/theme.dart';


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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          floating: true,
          actions: [
            IconButton(
              tooltip: 'profile',
              onPressed: () {
                bloc.hello('h');
                RouteMethods.navigateTo(
                    context: context, routeName: Profile.route);
              },
              icon: const Icon(Icons.person_outline_rounded),
            ),
            IconButton(
              tooltip: 'cart',
              onPressed: () => RouteMethods.navigateTo(
                  context: context, routeName: Cart.route),
              icon: const Icon(Icons.shopping_basket_outlined),
            ),
          ],
          title: Image.asset(
            AppAssets.appLogo,
            fit: BoxFit.fitHeight,
            height: 25.0,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 270.0,
            child: Placeholder(),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Center(
              child: Text(
                'I\'m looking for..',
                style: AppTheme.headerTextStyle,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const SizedBox(
                  width: 100.0,
                  child: Card(
                    child: Text('data'),
                  ),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Center(
              child: Text(
                'Featured Products',
                style: AppTheme.headerTextStyle,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.all(contentPadding),
              child: Center(
                child: SizedBox(
                  height: 20.0,
                  child: Text('$index'),
                ),
              ),
            ),
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
