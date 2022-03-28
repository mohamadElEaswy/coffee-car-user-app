//the services layer after login or register
// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mk/src/core/model/coffe_car_model/coffee_car_model.dart';
import 'package:mk/src/locations.dart';
import '../../../core/model/category_model/category_model.dart';
import '../../../core/model/product_model/product_model.dart';
import '../../../core/model/user_details_model/user_details_model.dart';
import 'firestore_services.dart';
// import 'firestore_services.dart';

abstract class Database {
  // Query getMessageQuery();
  // Stream carsStream();
  // Stream<List<CoffeeCar>> carsStream();

  late List<CoffeeCar> cars;
  late List<String> carsList;
  Future getCars();
  Future getCarsList();
  Future getCarDetails(String documentId);
  Future<void> testGetCars();

  Future addToFavourites({
    required String uid,
    required String productId,
    required Product product,
  });
  Future addToCart({
    required String uid,
    required String productId,
    required Product product,
  });
  //adding user data to fire store DB
  Future<void> addUser({
    required String uid,
    required String userName,
    required String phoneNumber,
    required String email,
    required String city,
    required String userType,
  });
  //get user data from fire store DB
  Future<UserDetails> getUser(String uid);
  Future<List<Cars>> getLocationsList();
  Future<List<Category>> getCategories({required String uId});
  Future getSingleProduct({required String uId, required String productId});
  Future<List<Product>> getProductsList({required String uId});
  Future<List<Product>> getFavourites({required String uid});
}

String documentIDCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase(
      // {required this.uid}
      );
  // final String uid;

  final FirebaseFirestore service = FirebaseFirestore.instance;
  final FireStoreService _service = FireStoreService.instance;

  @override
  List<CoffeeCar> cars = [];
  List test = [];
  @override
  Future getCars() async {
    return await service.collection('cars').get().then((value) {
      value.docs.forEach(
        (element) {
          test = value.docChanges.cast();
          cars.add(
            CoffeeCar.fromJson(element.reference.parent.parameters),
          );
        },
      );
      print(cars[0].carName);
    }).catchError((e) {
      print(e.toString());
      print(test.length);
      print(test[0].toString());
    });
  }

  // using this method I can get the list of documents form Firebase 'list of my cars id as String'
  @override
  List<String> carsList = [];
  @override
  Future getCarsList() async {
    carsList.clear();
    await service.collection('cars').get().then((value) {
      value.docs.forEach((element) {
        carsList.add(element.id);
      });
    });
  }

  late CoffeeCar coffeeCar;
  @override
  Future getCarDetails(String documentId) async {
    await service.collection('cars').doc(documentId).get().then((value) {
      print(value.data());
      coffeeCar = CoffeeCar.fromJson(value.data()!);
    });
  }

  final carsRef = FirebaseFirestore.instance
      .collection('cars')
      .withConverter<CoffeeCar>(
        fromFirestore: (snapshot, _) => CoffeeCar.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  @override
  Future<void> testGetCars() async {
    List<QueryDocumentSnapshot<CoffeeCar>> cars = await carsRef
        // .where('genre', isEqualTo: 'Sci-fi')
        .get()
        .then((snapshot) => snapshot.docs);
    cars.forEach((element) {
      print(element.data().carName);
    });
  }

  late UserDetails userDetailsModel;
  @override
  Future<UserDetails> getUser(String uid) async {
    print(uid);
    return await service.collection('users').doc(uid).get().then((value) {
      print(value.data());
      print(value.data()!.values);
      return UserDetails.fromJson(value.data()!);
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Future addToFavourites({
    required String uid,
    required String productId,
    required Product product,
  }) async {
    return await _service
        .setDataPath(
            path: 'users/$uid/favourites/$productId', data: product.toJson())
        .then((value) {print('added');})
        .catchError((e) {
      e.toString();
    });
    // .collection('users')
    // .doc(uid)
    // .collection('favourites')
    // .doc(productId)
    // .set(product.toJson());
  }

  @override
  Future addToCart({
    required String uid,
    required String productId,
    required Product product,
  }) async {
    return await service
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId)
        .set(product.toJson());
  }

  @override
  Future<void> addUser({
    required String uid,
    required String userName,
    required String phoneNumber,
    required String email,
    required String city,
    required String userType,
  }) async {
    userDetailsModel = UserDetails(
        uId: uid,
        userName: userName,
        phoneNumber: phoneNumber,
        email: email,
        city: city,
        userType: userType,
        joinDate: DateTime.now());
    await service
        .collection('users')
        .doc(uid)
        .set(userDetailsModel.toJson())
        .then(
          (value) => getUser,
        );
  }

  @override
  Future<List<Cars>> getLocationsList() async {
    List<Cars> locations = [];
    await service.collection('locations').get().then(
      (value) {
        value.docs.forEach(
          (element) {
            locations.add(Cars.fromJson(element.data()));
          },
        );
      },
    );

    // QuerySnapshot<Map<String, dynamic>> data = await _service.getData(
    //     documentPath: 'locations/');
    // data.docs.forEach(
    //   (element) {
    //     locations.add(Cars.fromJson(element.data()));
    //   },
    // );
    return locations;
  }

  @override
  Future<List<Category>> getCategories({required String uId}) async {
    List<Category> categories = [];
    await service
        .collection('providers')
        .doc(uId)
        .collection('categories')
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) {
              categories.add(
                Category.fromJson(element.data()),
              );
            },
          ),
        );
    return categories;
  }

  @override
  Future<Product> getSingleProduct(
      {required String uId, required String productId}) async {
    late Product product;
    // late Product product;
    // await _service
    //     .getData(documentPath: 'providers/$uId/products/$productId', )
    //     .then((value) => Product.fromJson(value)).catchError((e){print(e.toString());});
    await FirebaseFirestore.instance
        .collection('providers')
        .doc(uId)
        .collection('products')
        .doc(productId)
        .get()
        .then(
      (value) {
        product = Product.fromJson(value.data()!);
      },
    ).catchError((e) => print(e.toString()));
    return product;
  }

  @override
  Future<List<Product>> getProductsList({required String uId}) async {
    List<Product> products = [];
    products.clear();
    // QuerySnapshot<Map<String, dynamic>> snap = await _service.getDataCollection(
    //     documentPath: ApiPath.products(uId), collectionPath: 'products/');
    // // print(snap.docs[1].id);
    // snap.docs.forEach(
    //   (element) {
    //     products.add(Product.fromJson(element.data()));
    //     print(products.length);
    //   },
    // );
    // return products;

    await FirebaseFirestore.instance
        .collection('providers/')
        .doc(uId)
        .collection('products/')
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            products.add(Product.fromJson(element.data()));
          },
        );
      },
    );
    return products;
  }

  @override
  Future<List<Product>> getFavourites({required String uid}) async {
    List<Product> favourites = [];
    print(favourites.length);
    print(uid);
    print(favourites[0].name);
    favourites.clear();
    await service
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            favourites.add(Product.fromJson(element.data()));
          },
        );
      },
    ).catchError((e) => print(e.toString()));
    return favourites;
  }
}
