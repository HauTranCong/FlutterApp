import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viis_pyriot/%5B5%5DUser/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:viis_pyriot/%5B5%5DUser/profile_screen.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDisplayState>(
      builder: (context, value, child) =>
          value.count == 0 ? const LoginScreen() : const ProfileScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Login();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class UserDisplayState extends ChangeNotifier {
  late String _idToken;
  int _count = 0;

  int get count => _count;
  String get idToken => _idToken;

  set idToken(String value) {
    assert(value != null);
    _idToken = value;
  }

  void loginScreen() {
    _count = 0;
    notifyListeners();
  }

  void profileScreen() {
    _count = 1;
    notifyListeners();
  }
}
