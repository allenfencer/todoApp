import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchProductData extends StatefulWidget {
  static String id ='fetchProductData_screen';
  const FetchProductData({Key key}) : super(key: key);

  @override
  _FetchProductDataState createState() => _FetchProductDataState();
}

class _FetchProductDataState extends State<FetchProductData>{
  CollectionReference products=FirebaseFirestore.instance.collection('subjects');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Database'),
      ),
      body: StreamBuilder(
        stream: products.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasData)
          {
            return ListView(
              children: snapshot.data.docs.map((e) => ListTile(
                leading: Text(e['student_name']),
                title: Text(e['name']),
                trailing: Text('${e['marks']}/100'),
              )).toList(),
            );
          }
          else if(!snapshot.hasData)
          {
            return Center(child: ListTile(
              title: Text('Please wait your data is being fetched'),
              subtitle: Center(child: CircularProgressIndicator()),
            ));
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
