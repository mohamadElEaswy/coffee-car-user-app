import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/ui/pages/provider_products_page/products_page_body.dart';
import '../../../core/bloc/cubit/cubit.dart';
import '../../../core/bloc/states/states.dart';
import '../../colors/static_colors.dart';

class ProviderProductsPage extends StatelessWidget {
  static const String route = '/provider_products_page';

   ProviderProductsPage({
    Key? key,
    required this.providerId,
  }) : super(key: key);

  final dynamic providerId;

  static Radius radius = const Radius.circular(40);

  List<Widget> actions = [
    IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit bloc = AppCubit.get(context);

        return FutureBuilder(
          future: bloc.fetchAllCategories(providerId.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Scaffold(
              // backgroundColor: Colors.grey[200],
              body: DefaultTabController(
                length:
                    1 //TODO add Tabs and fix this issue to create taps and tabs boy dynamically
                // +
                // bloc.categoriesNameList.length
                ,
                initialIndex: 0,
                child: NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverAppBar(
                        // flexibleSpace: const FlexibleSpaceBar(
                        //   title: Text("Some title"),
                        //   titlePadding: EdgeInsets.all(5),centerTitle: true,
                        // ),
                        // expandedHeight: 140,
                        actions: actions,
                        // title: const Text('provider details'),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(100),
                          child: Column(
                            children: [
                              const Text('Starbucks car'),
                              const SizedBox(height: 10),
                              Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: GlobalStaticColors.buttonBrown,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    '4.2',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                              const SizedBox(height: 10),
                              Container(
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: radius,
                                    topRight: radius,
                                  ),
                                ),
                                child: TabBar(
                                  // controller: _tabController,
                                  isScrollable: true,
                                  tabs: bloc.tabs,
                                  labelColor: Colors.black,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  indicatorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      AllProductsPage(providerId: providerId),
                      // bloc.categoriesNameList.length;
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
