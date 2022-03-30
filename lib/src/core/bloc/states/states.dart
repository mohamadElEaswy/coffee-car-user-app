abstract class AppState {}

class InitialAppState extends AppState {}

class LoadingAppState extends AppState {}

class ErrorAppState extends AppState {
  final String error;

  ErrorAppState({required this.error});
}

class SuccessAppState extends AppState {}

//home maps states
class LoadingMapsState extends AppState {}

class SuccessMapsState extends AppState {}

class ErrorMapsState extends AppState {
  final String error;

  ErrorMapsState({required this.error});
}

// change screen state

class ChangeScreenState extends AppState {
  final int currentScreen;

  ChangeScreenState(this.currentScreen);
}

class ChangeMapPosition extends AppState {}

class ProductsLoadingState extends AppState {}

class ProductsSuccessState extends AppState {}

class ProductsErrorState extends AppState {
  ProductsErrorState({required this.error});
  final String error;
}

class CategoryLoadingState extends AppState {}

class CategorySuccessState extends AppState {}

class CategoryErrorState extends AppState {
  CategoryErrorState({required this.error});
  final String error;
}

class FavouritesLoadingState extends AppState {}

class FavouritesSuccessState extends AppState {}

class FavouritesErrorState extends AppState {
  FavouritesErrorState({required this.error});
  final String error;
}

class AddToFavouriteLoadingState extends AppState {}

class AddToFavouriteSuccessState extends AppState {}

class AddToFavouriteErrorState extends AppState {
  AddToFavouriteErrorState({required this.error});
  final String error;
}

class AddToCartLoadingState extends AppState {}

class AddToCartSuccessState extends AppState {}

class AddToCartErrorState extends AppState {
  AddToCartErrorState({required this.error});
  final String error;
}

class CartLoadingState extends AppState {}

class CartSuccessState extends AppState {}

class CartErrorState extends AppState {
  CartErrorState({required this.error});
  final String error;
}

class DeleteCartItemSuccessState extends AppState {}

class DeleteCartItemLoadingState extends AppState {}

class DeleteCartItemErrorState extends AppState {
  DeleteCartItemErrorState({required this.error});
  final String error;
}
