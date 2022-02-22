import 'package:flutter/material.dart';
import 'package:mk/src/ui/pages/provider_products_page/products_page_body.dart';

class ProviderProductsPage extends StatefulWidget {
  static const String route = '/provider_products_page';

  const ProviderProductsPage({Key? key}) : super(key: key);
  @override
  MyScrollTabListHomePageState createState() {
    return MyScrollTabListHomePageState();
  }
}

class MyScrollTabListHomePageState extends State<ProviderProductsPage>
    with SingleTickerProviderStateMixin {
  static Radius radius = const Radius.circular(40);
  List<Tab> tabs = const [
    Tab(text: 'All'),
    Tab(text: 'Coffee'),
    Tab(text: 'Tea'),
    Tab(text: 'Cold Drinks'),
    Tab(text: 'Cold Drinks'),
  ];
  List<Widget> actions = [
    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
  ];

  List<Widget> tabBarViewList = const [
    AllProductsPage(),
    Icon(Icons.directions_transit, size: 350),
    Icon(Icons.directions_car, size: 350),
    Icon(Icons.directions_car, size: 350),
    Icon(Icons.directions_car, size: 350),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                expandedHeight: 140,
                actions: actions,
                title: const Text('provider details'),
                bottom: TabBar(
                  // controller: _tabController,
                  isScrollable: true,
                  tabs: tabs,
                  labelColor: Colors.black,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  indicatorColor: Colors.black,
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(topLeft: radius, topRight: radius),
            ),
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: tabBarViewList,
            ),
          ),
        ),
      ),
    );
  }
}
