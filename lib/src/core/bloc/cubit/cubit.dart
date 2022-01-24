// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/bloc/states/states.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);
 void hello(String h) {
    print(h);
  }
}