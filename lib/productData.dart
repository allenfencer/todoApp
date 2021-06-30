import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color primaryBg = Color(0xff18203d);


class ProductDetail extends StatefulWidget {
  static String id='product_screen';
  const ProductDetail({Key key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _priceController=TextEditingController();
  TextEditingController _brandController=TextEditingController();

  CollectionReference products= FirebaseFirestore.instance.collection('phones');

  Map<String,dynamic> addProducts;

  sendToDataBase(){
    addProducts={
      'name': _nameController.text,
      'brand': _brandController.text,
      'price': _priceController.text,
    };
    products.add(addProducts);
    _nameController.clear();
    _priceController.clear();
    _brandController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBg,
      appBar: AppBar(
        title: Text('FireStore Database',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(height: 100,),
            textInputField(label: 'Product Name',hint: 'eg: Iphone 12 Pro',controller: _nameController),
            SizedBox(height: 20,),
            textInputField(label: 'Brand Name',hint: 'eg: Apple',controller: _brandController),
            SizedBox(height: 20,),
            textInputField(label: 'Price',hint: 'eg: 85,000',controller: _priceController),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 70),
              child: MaterialButton(
                onPressed: sendToDataBase,
                height: 60,
                textColor: Colors.blue,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text('Add to Database',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



textInputField({String label,String hint,TextEditingController controller}){
  return TextField(
    controller: controller,
    style: TextStyle(fontSize: 18,color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 18,color: Colors.white),
      hintText: hint,
      hintStyle: TextStyle(fontSize: 16,color: Colors.grey[500]),
      border: InputBorder.none,
      enabled: true,
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(width: 2,color: Colors.tealAccent)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(width: 2,color: Colors.tealAccent)),
    ),
  );
}