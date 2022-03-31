import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/ui/colors/static_colors.dart';
import 'package:mk/src/ui/widgets/loading_widget.dart';
import 'favourites_card.dart';

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
        if (bloc.allFavouritesList.isNotEmpty) {
          return Container(
            color: GlobalStaticColors.greyBackground,
            child: ListView.builder(
              itemCount: bloc.allFavouritesList.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                return FavouritesCard(index, bloc);
              },
            ),
          );
        } else if (state is FavouritesLoadingState) {
          return const GlobalLoading();
        } else if (bloc.allFavouritesList.isEmpty) {
          return const Center(child: Text('your favourites list is empty'));
        } else {
          return const Center(child: Text('Error occurred'));
        }
      },
    );
  }
}
