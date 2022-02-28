import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';

class HomeMap extends StatelessWidget {
  const HomeMap({Key? key, required this.bloc}) : super(key: key);
  final AppCubit bloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[100],
      child: Center(
        child: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          // myLocationButtonEnabled: true,
          onMapCreated: bloc.onMapCreated,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: bloc.center,
            zoom: 11.0,
          ),
          cameraTargetBounds: CameraTargetBounds.unbounded,
          markers: bloc.markers.values.toSet(),
          // myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: false,
          mapToolbarEnabled: false,
        ),
      ),
    );
  }
}
