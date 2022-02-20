//the services layer after login or register
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mk/src/core/model/coffe_car_model/coffee_car_model.dart';
import 'package:mk/src/services/remote/firebase/firestore_services.dart';
import 'package:mk/src/ui/pages/stream_test_page/stream_test.dart';

import 'api_path.dart';

abstract class Database {
  // Query getMessageQuery();
  // Stream carsStream();
  // Stream<List<CoffeeCar>> carsStream();

}

String documentIDCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase(
      // {required this.uid}
      );
  // final String uid;
  // final FireStoreService _service = FireStoreService.instance;
  final FirebaseFirestore _service = FirebaseFirestore.instance;
  // Stream<CoffeeCar> jobStream(CoffeeCar coffeeCar) => _service.documentStream(
  //   path: ApiPath.allCars(),
  //   builder: (data, documentId) => CoffeeCar.fromJson(data!),
  // );
  @override
  // Stream<List<CoffeeCar>> carsStream() => _service.collectionStream(
  //   path: ApiPath.allCars,
  //   builder: (data) => CoffeeCar.fromJson(data),
  // );

  final DatabaseReference messagesRef =
  FirebaseDatabase.instance.ref().child('users');


  // Stream carsStream() {
  //    _service.collection('cars')
  //       .snapshots()
  //       .map((snapShot) => snapShot.docChanges
  //       .map((document) => CoffeeCar.fromJson(document.data))
  //       .toList());
  //    return _messagesRef.get();
  // }
  // @override
  // Stream<List<CoffeeCar>> carsStream() => _service.documentStream(
  //       path: ApiPath.allCars(),
  //       builder: (data, documentId) => CoffeeCar.fromJson(data!),
  //     );



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