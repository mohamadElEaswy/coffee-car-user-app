import 'package:cloud_firestore/cloud_firestore.dart';
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
    final  Stream<QuerySnapshot> getData = FirebaseFirestore.instance.collection('cars').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: getData,
      builder: (context, snapshot) {
        print(snapshot.data);
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['address']),
              subtitle: Text(document.id),
            );
          }).toList(),
        );
      },
    );
  }
}
