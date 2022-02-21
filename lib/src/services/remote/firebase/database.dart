//the services layer after login or register
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mk/src/core/model/coffe_car_model/coffee_car_model.dart';


import 'api_path.dart';

abstract class Database {
  // Query getMessageQuery();
  // Stream carsStream();
  // Stream<List<CoffeeCar>> carsStream();

  late List<CoffeeCar> cars;
  late List<String> carsList;
  Future getCars();
  Future getCarsList();
  Future getCarDetails(String documentId);
}

String documentIDCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase(
      // {required this.uid}
      );
  // final String uid;

  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  List<CoffeeCar> cars = [];
  List test =[];
  @override
  Future getCars() async {
    return await _service
        .collection('cars')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        test = value.docChanges.cast();
        cars.add(CoffeeCar.fromJson(element.reference.parent.parameters));



      });
      print(cars[0].carName);
    }).catchError((e){print(e.toString());print(test.length);print(test[0].toString());});

  }

  // using this method I can get the list of documents form Firebase 'list of my cars id as String'
  @override
  List<String> carsList =[];
  @override
  Future getCarsList() async{
    carsList.clear();
    await _service.collection('cars').get().then((value) {
      value.docs.forEach((element) {carsList.add(element.id);});
    });
  }
  late CoffeeCar coffeeCar;
  @override
  Future getCarDetails(String documentId) async{
    await _service.collection('cars').doc(documentId).get().then((value){
      print(value.data());
      coffeeCar = CoffeeCar.fromJson(value.data()!);

    });

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
