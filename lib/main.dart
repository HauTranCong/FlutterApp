import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viis_pyriot/%5B5%5DUser/user.dart';
import 'package:viis_pyriot/[2]Home/Garden/sky_garden.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '[0]Introduce/onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => UserDisplayState()),
      ],
      child: const MyApp(),
    ),
  );

  // runApp(const MyApp());
}

// Future initialization(BuildContext? context) async {
//   await Future.delayed(const Duration(milliseconds: 500));
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
