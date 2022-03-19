import 'package:cloud_firestore/cloud_firestore.dart';


class FireStoreService {
  FireStoreService._();
  static final instance = FireStoreService._();
  //global method to send data to Cloud FireStore DataBases
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    String? collectionPath,
  }) async {
    final reference =
    FirebaseFirestore.instance.doc(path).collection(collectionPath!);
    // print('$path : $data');
    await reference.add(data);
  }

  // Future<void> addSingleProduct({
  //   required String uId,
  //   required String name,
  //   required String price,
  //   required String description,
  //   required String category,
  // }) async {
  //   final fireStoreInstance = FirebaseFirestore.instance;
  //   String createDocId =
  //       fireStoreInstance.collection('providers/$uId/products/').doc().id;
  //   await fireStoreInstance
  //       .collection('providers/$uId/products/')
  //       .doc(createDocId)
  //       .set(Product(
  //     name: name,
  //     time: DateTime.now(),
  //     price: price,
  //     description: description,
  //     category: category,
  //     id: createDocId,
  //     availability: true,
  //   ).toJson());
  // }

  Future<void> setDataPath({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('$path : $data');
    await reference.set(data);
  }

  Future<void> updateData(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('$path : $data');
    await reference.update(data);
  }

  Future getData({required String documentPath}) async {
    final reference = FirebaseFirestore.instance.doc(documentPath).get();
    return reference;
  }


  Future<QuerySnapshot<Map<String, dynamic>>> getDataCollection(
      {required String documentPath, required String collectionPath}) async {
    final Future<QuerySnapshot<Map<String, dynamic>>> reference =
    FirebaseFirestore.instance
        .doc(documentPath)
        .collection(collectionPath)
        .get();
    return reference;
  }


  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('delete $path');
    await reference.delete();
  }

//Global method to get data from Cloud FireStore databases as a live stream
  Stream<List<T>> collectionStream<T>({
    required String? path,
    required T Function(dynamic data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path!);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()!, snapshot.id));
  }
}