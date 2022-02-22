import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mk/src/ui/pages/product_detail_page/size_section.dart';
import 'package:mk/src/ui/pages/product_detail_page/sugar_section.dart';
import 'package:mk/src/ui/pages/product_detail_page/title_sction.dart';
import 'package:mk/src/ui/pages/product_detail_page/total_section.dart';

import '../../colors/static_colors.dart';
import '../../constants.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_divider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  static const String route = '/product_detail_page';
  static const Radius topRadius = Radius.circular(40);
  void actionButtonPress() {}
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      IconButton(
          onPressed: actionButtonPress, icon: const Icon(FontAwesomeIcons.heart))
    ];

    return Scaffold(
        backgroundColor: Colors.grey[200],
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
                    padding: const EdgeInsets.only(bottom: 20),
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
            padding: const EdgeInsets.only(
              left: StaticConstants.globalPadding,
              right: StaticConstants.globalPadding,
            ),
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
                  const SizedBox(height: StaticConstants.globalPadding),
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
                    color: GlobalStaticColors.deepBlue,
                  ),
                  const SizedBox(height: 30),
                  GlobalButton(
                    onPressed: () {},
                    text: 'order now',
                    color: GlobalStaticColors.buttonBrown,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
