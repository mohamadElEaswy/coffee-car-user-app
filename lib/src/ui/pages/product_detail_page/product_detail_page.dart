import 'package:flutter/material.dart';
import 'package:mk/src/ui/pages/product_detail_page/size_section.dart';
import 'package:mk/src/ui/pages/product_detail_page/sugar_section.dart';
import 'package:mk/src/ui/pages/product_detail_page/title_sction.dart';
import 'package:mk/src/ui/pages/product_detail_page/total_section.dart';

import '../../widgets/global_button.dart';
import '../../widgets/global_divider.dart';
import '../../widgets/plus_button.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  static const String route = '/product_detail_page';
  static const Radius topRadius = Radius.circular(40);
  void actionButtonPress() {}
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      IconButton(
          onPressed: actionButtonPress, icon: const Icon(Icons.heart_broken))
    ];

    return Scaffold(
        backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   backgroundColor: Colors.grey[200],
        //   // centerTitle: true,
        //   // title: const Text('provider details'),
        //   actions: actions,
        //   bottom: ,
        // ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.grey[200],
                // title: Text('Weight Tracker'),
                pinned: true,
                actions: actions,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(140),
                  child: Container(
                    height: 120,
                    color: Colors.grey[200],
                    child: const Center(
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Center(
                          child: Placeholder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              // border: Border.all(),
              borderRadius:
                  BorderRadius.only(topLeft: topRadius, topRight: topRadius),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleSection(),
                  const SizedBox(height: 30),
                  const SizeSection(),
                  const SizedBox(height: 40),
                  const SugarSection(),
                  const SizedBox(height: 30),
                  const MyGlobalDivider(),
                  const SizedBox(height: 30),
                  const TotalSection(),
                  const SizedBox(height: 30),
                  GlobalButton(
                    onPressed: () {},
                    text: 'Add to cart',
                  ),
                  const SizedBox(height: 30),
                  GlobalButton(
                    onPressed: () {},
                    text: 'order now',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
