import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color primaryBg = Color(0xff18203d);

class Home extends StatefulWidget {
  static String id='home_screen';
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final listController=TextEditingController();
  CollectionReference groceries=FirebaseFirestore.instance.collection('groceries');
  Map<String,dynamic> addGroceries;

  addItem(){
    addGroceries={
      'name': listController.text,
    };
    groceries.add(addGroceries);
    listController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 5,
        backgroundColor: Colors.blue,
        title: TextField(
          controller: listController,
          style: TextStyle(color: Colors.white,fontSize: 20),
          decoration: InputDecoration(
              hintText: 'Enter items',
              hintStyle:TextStyle(fontSize: 20,color: Colors.white),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: addItem,
                icon: Icon(Icons.add,size: 30,color: Colors.white,),),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: groceries.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasData)
            {
              return ListView(
                children: snapshot.data.docs.map((groceries) =>ListTile(
                  onLongPress: (){
                    groceries.reference.delete();
                  },
                  title: Text(groceries['name'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                )).toList(),
              );
            }
          else if(!snapshot.hasData)
            {
              return Center(child: ListTile(
                title: Text('Please wait a moment , your data is being fetched',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black),),
                subtitle: Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.black,),),
              ),);
            }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}
