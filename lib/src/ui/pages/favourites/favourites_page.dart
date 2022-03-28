import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/ui/widgets/loading_widget.dart';

import '../../../core/model/product_model/product_model.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);
  static const String route = '/favourites_page';

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit bloc = AppCubit.get(context);
        return FutureBuilder(
          future: bloc.getFavourites(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            return snapshot.hasData && snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Text(snapshot.data![index].name);
                    },
                  )
                : const GlobalLoading();
          },
        );
      },
    );
  }
}
