import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/cubit/cubit.dart';
import '../../../core/bloc/states/states.dart';
import '../../../locations.dart';

class ProvidersPage extends StatelessWidget {
  const ProvidersPage({Key? key}) : super(key: key);
  static const String route = 'providers_page';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AppCubit bloc = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Our Providers'),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            itemCount: bloc.data.length,
            itemBuilder: (BuildContext context, int index) {
              return cardItem(
                context: context,
                car: bloc.data[index],
              );
            },
          ),
        );
      },
    );
  }

  Widget cardItem(
          {
            // required Office item,
          required BuildContext context,
          required Cars car,
          }) =>
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 225,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(car.name),
                Container(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 5, bottom: 5),
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xfffA9927D),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.white,
                      ),
                      Text(
                        '4.0',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.not_listed_location_outlined,
                      size: 15,
                      // color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      car.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(),
                    ),
                    const Spacer(),
                    const Icon(Icons.watch_later)
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.watch_later_rounded,
                      size: 15,
                      // color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Open 24 hors',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
