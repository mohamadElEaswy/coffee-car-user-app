//the services layer after login or register
// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mk/src/core/model/coffe_car_model/coffee_car_model.dart';

import '../../../core/model/user_details_model/user_details_model.dart';

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

  //store user data from fire store into model
  late UserDetails userDetailsModel;
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
  Future<void> getUser(String uid);
}

String documentIDCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase(
      // {required this.uid}
      );
  // final String uid;

  final FirebaseFirestore service = FirebaseFirestore.instance;

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








  @override
  late UserDetails userDetailsModel;
  @override
  Future<void> getUser(String uid) async {
    await service.collection('users').doc(uid).get().then(
        (value) => userDetailsModel = UserDetails.fromJson(value.data()!) );
    print(userDetailsModel.uId);
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
    );
    await service
        .collection('users')
        .doc(uid)
        .set(userDetailsModel.toJson())
        .then(
          (value) => getUser,
        );
  }
}

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('pets');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // 3
  // Future<DocumentReference> addPet(CoffeeCar coffeeCar) {
  //   return collection.add(coffeeCar.toJson());
  // }
  // 4
  // void updatePet(CoffeeCar coffeeCar) async {
  //   await collection.doc(coffeeCar.referenceId).update(coffeeCar.toJson());
  // }
  // 5
  // void deletePet(CoffeeCar coffeeCar) async {
  //   await collection.doc(coffeeCar.referenceId).delete();
  // }
}
