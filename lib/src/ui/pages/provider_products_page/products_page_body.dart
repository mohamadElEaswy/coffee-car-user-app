import 'package:flutter/material.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/ui/widgets/loading_widget.dart';
import '../../../core/model/product_model/product_model.dart';
import 'grid_item.dart';

// import 'package:async/async.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage(this.bloc, {Key? key}) : super(key: key);

  final AppCubit bloc;

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.bloc.fetchAllProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.data != null) {
          return OrientationBuilder(
            builder: (context, orientation) {
              // print(snapshot.);
              return GridView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        orientation == Orientation.portrait ? 2 : 4),
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ProductGridItem(snapshot.data![index]);
                },
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const GlobalLoading();
        } else if (snapshot.data!.isEmpty) {
          return const Center(child: Text('sorry, there is no products yet'));
        } else {
          return const Center(child: Text('unknown error occurred'));
        }
      },
    );
  }
}
