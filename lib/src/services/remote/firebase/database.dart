//the services layer after login or register
import 'package:mk/src/core/model/coffe_car_model/coffee_car_model.dart';
import 'package:mk/src/services/remote/firebase/firestore_services.dart';
import 'package:mk/src/ui/pages/stream_test_page/stream_test.dart';

import 'api_path.dart';

abstract class Database {

  // Stream<List<CoffeeCar>> carsStream();

}

String documentIDCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase(
      // {required this.uid}
      );
  // final String uid;
  final _service = FireStoreService.instance;


  // @override
  // Stream<List<CoffeeCar>> carsStream() => _service.documentStream(
  //       path: ApiPath.allCars(),
  //       builder: (data, documentId) => CoffeeCar.fromJson(data!),
  //     );



}
