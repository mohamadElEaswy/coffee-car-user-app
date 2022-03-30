import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/ui/widgets/loading_widget.dart';


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
          return ListView.builder(
          itemCount: bloc.allFavouritesList.length, padding: const EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int index) {
            return Text(bloc.allFavouritesList[index].name);
          },
        );
        }else if (state is FavouritesLoadingState){
          return const GlobalLoading();
        }else{ return const Center(child: Text('Error occurred'));}
      },
    );
  }
}
