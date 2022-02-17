//the services layer after login or register
import 'package:mk/src/core/model/coffe_car_model/coffee_car_model.dart';
import 'package:mk/src/services/remote/firebase/firestore_services.dart';

import 'api_path.dart';

abstract class Database {
  // Future<void> setJob(Job job);
  // Future<void> deleteJob(Job job);
  Stream<CoffeeCar> carsStream();
  // Stream<List<CoffeeCar?>> carsStream();

  // Stream<Job> jobStream(Job job);
  // Future<void> setEntry(Entry entry);
  // Future<void> deleteEntry(Entry entry);
  // Stream<List<Entry>> entriesStream({Job job});
}

String documentIDCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase(
      // {required this.uid}
      );
  // final String uid;
  final _service = FireStoreService.instance;

//send data to Cloud FireStore DataBase
//   @override
//   Future<void> setJob(Job job) =>
//       _service.setData(path: ApiPath.job(uid, job.id), data: job.toMap());
//
//   @override
//   Future<void> deleteJob(Job job) async {
//     final allEntries = await entriesStream(job: job).first;
//     for (Entry entry in allEntries) {
//       if (entry.jobId == job.id) {
//         await deleteEntry(entry);
//       }
//     }
//     _service.deleteData(path: ApiPath.job(uid, job.id));
//   }

  // @override
  // Stream<Job> jobStream(Job job) => _service.documentStream(
  //       path: ApiPath.job(uid, job.id),
  //       builder: (data, documentId) => Job.fromMap(data!, documentId),
  //     );
  @override
  Stream<CoffeeCar> carsStream() => _service.documentStream(
        path: ApiPath.allCars(),
        builder: (data, documentId) => CoffeeCar.fromJson(data!),
      );
//the coming data from Cloud FireStore DataBase
//   @override
//   Stream<List<CoffeeCar>> carsStream() => _service.collectionStream(
//         path: ApiPath.allCars(),
//         builder: (data, documentId) => CoffeeCar.fromJson(data),
//       );


//   @override
//   Future<void> setEntry(Entry entry) async {
//     _service.setData(
//       path: ApiPath.entry(uid, entry.id),
//       data: entry.toMap(),
//     );
//     // _service.setData(
//     //   path: ApiPath.entries(uid),
//     //   data: entry.toMap(),
//     // );
//   }
//
//   @override
//   Future<void> deleteEntry(Entry entry) => _service.deleteData(
//         path: ApiPath.entry(uid, entry.id),
//       );
//
//   @override
//   Stream<List<Entry>> entriesStream({Job? job}) =>
//       _service.collectionStream<Entry>(
//         path: ApiPath.entries(uid),
//         queryBuilder: job != null
//             ? (query) => query.where('jobId', isEqualTo: job.id)
//             : null,
//         builder: (data, documentID) => Entry.fromMap(data, documentID),
//         sort: (lhs, rhs) => rhs.start!.compareTo(lhs.start!),
//       );
}
