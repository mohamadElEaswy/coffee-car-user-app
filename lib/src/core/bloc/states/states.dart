abstract class AppState{}

class InitialAppState extends AppState{}

class LoadingAppState extends AppState{}

class ErrorAppState extends AppState{
  final String error;

  ErrorAppState({required this.error});
}

class SuccessAppState extends AppState{}


//home maps states
class LoadingMapsState extends AppState{}
class SuccessMapsState extends AppState{}
class ErrorMapsState extends AppState{
  final String error;

  ErrorMapsState({required this.error});
}

// change screen state

class ChangeScreenState extends AppState{}
class ChangeMapPosition extends AppState{}
