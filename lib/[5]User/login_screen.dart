import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viis_pyriot/%5B5%5DUser/user.dart';
import 'auth_serivce.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // static Future<User?> loginUsingEmailPassword({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // }) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       print("No user found for that email");
  //     }
  //   }
  //   return user;
  // }
  final AuthService _auth = AuthService();
  late User? user;

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "MyApp Title",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Login To Your App",
          style: TextStyle(
            color: Colors.black,
            fontSize: 44.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: "User Email",
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.black,
              )),
        ),
        const SizedBox(
          height: 26.0,
        ),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "User Password",
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              )),
        ),
        const SizedBox(
          height: 12.0,
        ),
        const Text(
          "Don't Remember your Password?",
          style: TextStyle(color: Colors.blue),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.transparent,
          width: double.infinity,
          child: RawMaterialButton(
            fillColor: const Color.fromARGB(255, 68, 196, 161),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () async {
              user = await _auth.loginUsingEmailPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
              if (user != null) {
                Provider.of<UserDisplayState>(context, listen: false)
                    .profileScreen();
                Provider.of<UserDisplayState>(context, listen: false).idToken =
                    user!.uid;
              }
              print(user);
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.transparent,
          width: double.infinity,
          child: RawMaterialButton(
            fillColor: const Color.fromARGB(255, 68, 196, 161),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () async {
              user = await _auth.singInAnonymously();
              if (user == null) {
                print('error signing in');
              } else {
                print('signed in anonymously');
                print(user.runtimeType);
                Provider.of<UserDisplayState>(context, listen: false)
                    .profileScreen();
                Provider.of<UserDisplayState>(context, listen: false).idToken =
                    user!.uid;
              }
            },
            child: const Text(
              "Guest",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: column,
      ),
    );
  }
}
