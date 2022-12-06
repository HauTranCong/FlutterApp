import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyGarden extends StatefulWidget {
  const MyGarden({Key? key}) : super(key: key);
  @override
  State<MyGarden> createState() => _MyGardenState();
}

class CounterProvider extends ChangeNotifier {
  int _count = 100;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  // /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('count', count));
  // }
}

class _MyGardenState extends State<MyGarden> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, value, child) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.red,
                // width: MediaQuery.of(context).size.width,
                child: Text(value.count.toString()),
              ),
            ),
            // Scaffold(
            //     body: GardenForm(),
            //     )
          ],
        ),
      ),
    );
  }
}

// SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               color: Colors.red,
//               width: MediaQuery.of(context).size.width,
//               child: Text(context.watch<CounterProvider>().counter.toString()),
//             ),
//           )
//         ],
//       ),
//     );