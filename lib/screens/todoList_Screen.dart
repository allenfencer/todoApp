import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_demo/screens/editScreen.dart';
import 'package:database_demo/screens/newTodo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TodoScreen extends StatelessWidget {
  static String id="todo_screen";
  const TodoScreen({Key key}) : super(key: key);
  static CollectionReference notes=FirebaseFirestore.instance.collection('notes');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Todos',style: TextStyle(fontSize: 22,color: Colors.lightGreenAccent,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        onPressed: (){
          Navigator.pushNamed(context, NewTodo.id);
        },
        child: Icon(Icons.add,color: Colors.grey[900],size: 30,),
      ),
      body: StreamBuilder(
        stream: notes.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasData)
            {
              return ListView.builder(
                  itemCount: snapshot.hasData?snapshot.data.docs.length:0,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                      child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.grey.withOpacity(0.6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            horizontalTitleGap: 5,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditScreen(editableDoc: snapshot.data.docs[index],)));
                            },
                            title: Text('${snapshot.data.docs[index]['title']}',style: TextStyle(fontSize: 20,color: Colors.lightGreenAccent,fontWeight: FontWeight.w600),),
                            subtitle: Text('${snapshot.data.docs[index]['description']}',style: TextStyle(fontSize: 16,color: Colors.white),),
                          )
                      ),
                    );
                  }
              );
            }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
