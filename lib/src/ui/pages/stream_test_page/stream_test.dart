import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/remote/firebase/database.dart';

class StreamTestPage extends StatelessWidget {
  const StreamTestPage({Key? key}) : super(key: key);
  static const String route = '/stream_test_page';
  Future<void> getStreamData(BuildContext context) async {
    // final database = Provider.of<Database>(context, listen: false);
    // database.carsStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildStreamContent(context),
    );
  }


  Widget _buildStreamContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    // final  Stream<List<CoffeeCar>> getData = FirebaseFirestore.instance.collection('cars').snapshots();
    // Stream collectionStream = FirebaseFirestore.instance.collection('cars').snapshots();
    // final DataRepository repository = DataRepository();
    // Stream getFromFirebase(){
    //   return FirebaseFirestore.instance.collection('cars').snapshots();
    // }
    // final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child('users');
    // print(messagesRef.key.toString());
    CollectionReference cars = FirebaseFirestore.instance.collection('cars');
    return FutureBuilder(
      future: database.getCarsList()
      // Provider.of<Database>(context).getCars()
      ,
      builder: (BuildContext  context,  AsyncSnapshot snapshot) {
        // var data = snapshot.data!.data();
        return ListView.builder(
          itemCount: database.carsList.length,
          itemBuilder: (context, index){
            return Center(
              child: ListTile(
                title: Text(database.carsList[index]),
                onTap: ()=> database.getCarDetails(database.carsList[index].toString()),
              ),
            );
          },
          );
      },);
  }
}
