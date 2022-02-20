import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mk/src/core/model/coffe_car_model/coffee_car_model.dart';
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
    // final database = Provider.of<Database>(context, listen: false);
    // final  Stream<List<CoffeeCar>> getData = FirebaseFirestore.instance.collection('cars').snapshots();
    // Stream collectionStream = FirebaseFirestore.instance.collection('cars').snapshots();
    // final DataRepository repository = DataRepository();
    Stream getFromFirebase(){
      return FirebaseFirestore.instance.collection('cars').snapshots();
    }
    // final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child('users');
    // print(messagesRef.key.toString());
    return Expanded(
      child: StreamBuilder(
        stream: getFromFirebase(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // final json = snapshot.value as Map<String, dynamic>;
          // final message = CoffeeCar.fromJson(json);
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
            return  ListTile(
              title:  Text('document'),
              // subtitle:  Text(document['phone']),
            );
          }).toList());
        },
      ),
    );
  }
}
