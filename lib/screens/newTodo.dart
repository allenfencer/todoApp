import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NewTodo extends StatefulWidget {
  static String id='new_todo';
  const NewTodo({Key key}) : super(key: key);

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  CollectionReference notes=FirebaseFirestore.instance.collection('notes');
  final title=TextEditingController();
  final description=TextEditingController();
  Map<String,dynamic> todoData;

  addTodoToDB(){
    todoData={
      'title':title.text,
      'description':description.text,
    };
    notes.add(todoData).whenComplete(() => Navigator.pop(context));
    title.clear();
    description.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        onPressed: addTodoToDB,
        child: Icon(Icons.save,color: Colors.grey[900],size: 28,),
      ),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              padding:EdgeInsets.only(right: 30),
              icon: Icon(Icons.delete,color: Colors.redAccent,size: 34,), onPressed: (){}),
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          padding:EdgeInsets.only(left: 30),
          icon: Icon(Icons.arrow_back_ios,color: Colors.lightGreenAccent,size: 30,),),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20,right: 20,top: 50,bottom: 10),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.grey.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: title,
              minLines: 1,
              maxLines: 3,
              style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 1),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 20,color: Colors.grey),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18),borderSide: BorderSide(width: 2,color: Colors.blue)),
              ),
            ),
          ),
          SizedBox(height: 25,),
          Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.grey.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: TextField(
              style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 1.1),
              controller: description,
              minLines: 10,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'Add todos here',
                hintStyle: TextStyle(fontSize: 20,color: Colors.grey),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(width: 2,color: Colors.blue)),
              ),
            ),
          ),
        ],
      )
    );
  }
}
