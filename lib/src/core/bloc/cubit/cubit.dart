// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:mk/src/core/assets/assets.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk/src/core/model/user_details_model/user_details_model.dart';
import 'package:mk/src/services/remote/firebase/auth.dart';
import 'package:mk/src/ui/pages/cart/cart_page.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/likes_page/likes_page.dart';
import 'package:mk/src/ui/pages/profile/profile_page.dart';
import '../../../locations.dart';
import '../../../services/remote/firebase/database.dart';
import '../../../ui/pages/favourites/favourites_page.dart';
import '../../../ui/pages/provider_products_page/products_page_body.dart';
import '../../../ui/widgets/global_snack_bar.dart';
import '../../model/category_model/category_model.dart';
import '../../model/product_model/product_model.dart';
import 'package:async/src/async_memoizer.dart';
// import 'dart:math' show cos, sqrt, asin;

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);
  Database database = FirestoreDatabase();

  // static const String apiKey = 'AIzaSyB5s0q2PCjtitmESmmU8SsSNbbr3FrzbIc';
//get home map data methods
  //this var to create controller to change the view with the map in the home
  GoogleMapController? mapController;

  final Map<String, Marker> markers = {};
  LatLng center = const LatLng(30.0444, 31.2357);

  List<Cars> data = [];

  Future<void> onMapCreated(GoogleMapController controller) async {
    emit(LoadingMapsState());
    data.clear();
    await database.getLocationsList().then(
      (List<Cars> value) {
        data.addAll(value);
      },
    );
    // final carsList = await locations.getGoogleOffices();

    mapController = controller;

    // data = googleOffices.offices;

    markers.clear();
    // await calculateDistance();
    for (final car in data) {
      final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(30, 30), devicePixelRatio: 2.5),
        AppAssets.carIcon,
      );
      final marker = Marker(
        visible: true,
        markerId: MarkerId(car.name),
        position: LatLng(car.lat, car.lng),
        infoWindow: InfoWindow(
          title: car.name,
          snippet: car.address,
        ),
        icon: icon,
      );
      markers[car.name] = marker;
    }
    emit(SuccessMapsState());
  }

//this method is to change the map view in the home
  Future<void> changeMapView(
      {required double latitude, required double longitude}) async {
    return await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 17),
      ),
    );
  }

/*manage bottom navigation bar*/
  int currentIndex = 0;

  List<Widget> body = const [
    HomeBodyPage(),
    LikesPage(),
    Cart(),
    FavouritesPage(),
    Profile(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.house), label: 'Home', tooltip: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.objectGroup),
        label: 'Providers',
        tooltip: 'Providers'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), label: 'Cart', tooltip: 'Cart'),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorites', tooltip: 'Favorites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Profile', tooltip: 'Profile'),
  ];
  List<Widget> tabBarViewList = const [
    AllProductsPage(),
    // bloc.categoriesNameList.length;
  ];
  List<Tab> tabs = const [
    Tab(text: 'All'),
  ];
  void changeScreen({required int index}) {
    currentIndex = index;
    emit(ChangeScreenState());
  }
  //end bottom navigation bar

  //this method is to enable my current location into the home map.
  Location location = Location();
  late LocationData current;
  Future<LocationData> myLocation() async {
    current = await location.getLocation();
    return current;
  }

  //my location button in home screen
  //firstly check if location services permission is granted(true, or false) and ask the permission if it is not granted
  Future<void> myLocationButton() async {
    if (await location.serviceEnabled()) {
      return await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(current.latitude!, current.longitude!),
            zoom: 17,
          ),
        ),
      );
    } else {
      location.requestService();
    }
  }

  AuthBase auth = Auth();

  //using this String I path the provider id to present his products
  String? providerId;
  /*the coming method fixing future builder bug (keep firing)*/
  final AsyncMemoizer _memorize = AsyncMemoizer();
  late final Future<List<Product>> myFuture = getAllProductsList();
  Future<List<Product>> fetchAllProducts() async {
    // ignore: unnecessary_this
    return await this._memorize.runOnce(
      () {
        return myFuture;
      },
    );
  }

  //the coming method to fix loading taps problem
  final AsyncMemoizer _tapsMemorize = AsyncMemoizer();
  Future tapsFuture(String uid) => getCategories(uid);
  Future<List<Product>> fetchAllCategories(String uid) async {
    // ignore: unnecessary_this
    return await this._tapsMemorize.runOnce(
      () {
        return getCategories(uid);
      },
    );
  }

  Future<UserDetails> getUserData() async {
    return await database.getUser(auth.currentUser!.uid);
  }

  List<Product> allProductsList = [];
  Future<List<Product>> getAllProductsList() async {
    emit(ProductsLoadingState());

    List<Product> products = [];
    allProductsList.clear();
    List<Product> data = await database.getProductsList(uId: providerId!);
    products.addAll(data);
    allProductsList.addAll(data);
    emit(ProductsSuccessState());

    return data;
  }

  List<Product> productsByCategory({required String categoryName}) {
    print(categoryName);
    List<Product> categoryProductsList = [];
    allProductsList.forEach(
      (element) {
        if (element.category == categoryName) {
          categoryProductsList.add(element);
        }
      },
    );
    return categoryProductsList;
  }

  Future addToCart({
    required String productId,
    required Product product,
  }) async {
    emit(AddToCartLoadingState());
    await database
        .addToCart(
            uid: auth.currentUser!.uid, productId: productId, product: product)
        .then((value) {
      emit(AddToCartSuccessState());
    }).catchError((e) {
      emit(AddToCartErrorState(error: e.toString()));
    });
  }

  Future addToFavourites({
    required String productId,
    required Product product,
    // required BuildContext context,
  }) async {
    emit(AddToFavouriteLoadingState());
    await database
        .addToFavourites(
      uid: auth.currentUser!.uid,
      productId: productId,
      product: product,
    )
        .then((value) {
      emit(AddToFavouriteSuccessState());
    }).catchError((e) {
      emit(AddToFavouriteErrorState(error: e.toString()));
    });
  }

  Future getSingleProduct(String productId) async {
    await database
        .getSingleProduct(uId: auth.currentUser!.uid, productId: productId)
        .then((value) => print(value));
  }

  List<String> categoriesNameList = [];
  // List<Category> categoriesList = [];
  Future getCategories(String uid) async {
    emit(CategoryLoadingState());
    // categoriesList.clear();
    categoriesNameList.clear();
    await database.getCategories(uId: uid).then(
      (List<Category> value) {
        // categoriesList.addAll(value);
        categoriesNameList.addAll(value.map((e) => e.name));
        print(categoriesNameList);
        emit(CategorySuccessState());
      },
    ).catchError(
      (e) {
        print('categories error state' + e.toString());
        emit(CategoryErrorState(error: e.toString()));
      },
    );
  }

  List<Product> allFavouritesList = [];
  Future<List<Product>> getFavourites() async {
    List<Product> favourites = [];
    favourites.clear();
    allFavouritesList.clear();
    emit(FavouritesLoadingState());
    if (auth.currentUser != null) {
      await database
          .getFavourites(uid: auth.currentUser!.uid)
          .then((List<Product> value) {
        allFavouritesList.addAll(value);
        favourites.addAll(value);
        emit(FavouritesSuccessState());
      }).catchError((e) {
        emit(FavouritesErrorState(error: e.toString()));
      });
    }
    return favourites;
  }

  List<Product> cartList = [];
  Future<List<Product>> getCart() async {
    List<Product> cart = [];
    cart.clear();
    cartList.clear();
    emit(FavouritesLoadingState());
    if (auth.currentUser != null) {
      await database
          .getCart(uid: auth.currentUser!.uid)
          .then((List<Product> value) {
        cart.addAll(value);
        cartList.addAll(value);
        emit(FavouritesSuccessState());
      }).catchError((e) {
        emit(FavouritesErrorState(error: e.toString()));
      });
    }
    return cart;
  }
}
