import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mk/src/ui/pages/provider_products_page/products_page_body.dart';

class ProviderProductsPage extends StatelessWidget {
  const ProviderProductsPage({Key? key}) : super(key: key);

  static const String route = '/provider_products_page';
  void actionButtonPress() {}
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      IconButton(onPressed: actionButtonPress, icon: const Icon(Icons.search))
    ];
    List<Tab> tabs = const [
      Tab(text: 'All'),
      Tab(text: 'Coffee'),
      Tab(text: 'Tea'),
      Tab(text: 'Cold Drinks'),
      Tab(text: 'Cold Drinks'),
      // Tab(icon: Icon(Icons.directions_transit)),
      // Tab(icon: Icon(Icons.directions_car)),
    ];
    List<Widget> tabBarView = const [
      AllProductsPage(),
      Icon(Icons.directions_transit, size: 350),
      Icon(Icons.directions_car, size: 350),
      Icon(Icons.directions_car, size: 350),
      Icon(Icons.directions_car, size: 350),
    ];
    return DefaultTabController(
      length: 5,
      child: Scaffold(backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          title: const Text('provider details'),
          actions: actions,
          bottom: TabBar(isScrollable: true,
            tabs: tabs,labelColor: Colors.black,physics: const BouncingScrollPhysics(),padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        ),
        body: TabBarView(physics: const BouncingScrollPhysics(),
          children: tabBarView,
        ),
      ),
    );
  }
}
