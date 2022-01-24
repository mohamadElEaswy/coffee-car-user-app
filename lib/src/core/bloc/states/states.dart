abstract class AppState{}

class InitialAppState extends AppState{}

class LoadingAppState extends AppState{}

class ErrorAppState extends AppState{
  final String error;

  ErrorAppState({required this.error});
}

class SuccessAppState extends AppState{}