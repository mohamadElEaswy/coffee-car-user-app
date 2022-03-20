import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/ui/widgets/loading_widget.dart';
import '../../../core/model/product_model/product_model.dart';
import 'grid_item.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ProductsSuccessState) {
          print('success');
        }
      },
      builder: (context, state) {
        AppCubit bloc = AppCubit.get(context);
        late final Future<List<Product>> myFuture = bloc.getAllProductsList();
        return FutureBuilder(
          future: myFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (state is ProductsSuccessState) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  // print(snapshot.);
                  return GridView.builder(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            orientation == Orientation.portrait ? 2 : 4),
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ProductGridItem(index);
                    },
                  );
                },
              );
            } else if (state is ProductsLoadingState) {
              return const GlobalLoading();
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('sorry, there is no products yet'));
            } else {
              return const Center(child: Text('unknown error occurred'));
            }
          },
        );
      },
    );
  }
}
