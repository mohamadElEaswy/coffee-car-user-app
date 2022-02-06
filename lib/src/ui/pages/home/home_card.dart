import 'package:flutter/material.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';

import '../../../locations.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.item,
    required BuildContext context,
    required this.bloc,
  }) : super(key: key);
  final AppCubit bloc;
  final Office item;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(right: 10, left: 5),
      child: InkWell(
        onTap: () {
          bloc.changeMapView(latitude: item.lat, longitude: item.lng);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 225,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name),
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
                    Text('4.0',
                        style: TextStyle(color: Colors.white, fontSize: 10))
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
                    item.region,
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
}
