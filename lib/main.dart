import 'package:database_demo/screens/editScreen.dart';
import 'package:database_demo/screens/newTodo.dart';
import 'package:database_demo/screens/todoList_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: TodoScreen.id,
      routes:{
        TodoScreen.id:(context)=>TodoScreen(),
        NewTodo.id:(context)=>NewTodo(),
        EditScreen.id:(context)=>EditScreen(),
        // LoginPage.id : (context)=>LoginPage(),
        // FetchProductData.id:(context)=>FetchProductData(),
        // ProductDetail.id:(context)=>ProductDetail(),
        // Home.id: (context)=>Home(),
      } ,
    ),
  );
}