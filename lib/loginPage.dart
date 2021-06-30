import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data list.dart';

Color primaryBg = Color(0xff18203d);

class LoginPage extends StatefulWidget {
  static String id = 'login_screen';
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              Center(
                  child: Text(
                'Sign in to Kili\'s Nest',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 70,
              ),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                style: TextStyle(color: Colors.white, fontSize: 20),
                obscureText: false,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email_outlined,
                    size: 30,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  hintText: 'kingjones@email.com',
                  hintStyle: TextStyle(
                      fontSize: 20, color: Colors.grey.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                style: TextStyle(color: Colors.white, fontSize: 20),
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock_outline,
                    size: 30,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  hintText: 'password',
                  hintStyle: TextStyle(
                      fontSize: 20, color: Colors.grey.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              MaterialButton(
                height: 60,
                onPressed: () async {
                  try {
                    final user = await _auth.createUserWithEmailAndPassword(
                        email: _email, password: _password);
                    if (user != null) {
                      Navigator.pushNamed(context, Home.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.teal[700],
                elevation: 0,
                minWidth: 100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () async {
                  //google sign in
                  try{
                    final user= await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                    if(user!=null)
                    {
                      Navigator.pushNamed(context, Home.id);
                    }
                  }catch(e)
                  {
                    print(e);
                  }

                },
                color: Colors.cyan[900],
                minWidth: 100,
                height: 60,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
