import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viis_pyriot/[2]Home/Garden/sky_garden.dart';
import 'package:viis_pyriot/%5B2%5DHome/weather_fetch.dart';
import 'package:viis_pyriot/%5B2%5DHome/weather_model.dart';
import 'bottom_sheet_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const listHeader = [
    'Tất cả thiết bị',
    'Vườn',
    'Trang Trại',
    'Ao cá',
    'Ao tôm',
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherModel> futureWeather;
  final _controller = ScrollController();
  var position = 0;
  var topHeader = "";

  Widget? applyWidget() {
    switch (position) {
      case 0:
        setState(() {
          topHeader = HomePage.listHeader[0];
        });
        return const MyGarden();

      case 1:
        setState(() {
          topHeader = HomePage.listHeader[1];
        });
        return list();
      case 2:
        setState(() {
          topHeader = HomePage.listHeader[2];
        });
        return Container(
          color: Colors.blue,
          child: Center(
            child: Text(topHeader),
          ),
        );
      case 3:
        setState(() {
          topHeader = HomePage.listHeader[3];
        });
        return Container(
          color: Colors.orange,
          child: Center(
            child: Text(topHeader),
          ),
        );
      case 4:
        setState(() {
          topHeader = HomePage.listHeader[4];
        });
        return Container(
          color: Colors.orange,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Provider.of<CounterProvider>(context, listen: false)
                    .increment();
                // print(context.read<CounterProvider>().count);
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
    }
    return null;
  }

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    topHeader = HomePage.listHeader[0];
    //initial header name when activity start first time
    futureWeather = fetchWeather();
    // Provider.of<CounterProvider>(context);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isRight = _controller.position.pixels == 0;
        if (isRight) {
          // print('At the Right');
        } else {
          // print('At the Left');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        title: Row(
          children: [
            Image.asset(
              width: 100,
              height: 40,
              'images/home_viis.png',
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Container(
              color: Colors.transparent,
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    // width: 40,
                    bottomSheetContents[0].image,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    bottomSheetContents[0].title,
                    style: const TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 70, 56, 57),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    child: Image.asset(
                      // width: 40,
                      'images/home/dropDownSymbol.png',
                    ),
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(15.0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        builder: (BuildContext context) {
                          return Container(
                            height: 350,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 2,
                                    left: 15,
                                  ),
                                  child: Text(
                                    'Dự án (${bottomSheetContents.length})',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 70, 56, 57),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: bottomSheetContents.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 15,
                                          right: 15,
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 237, 240, 244),
                                            width: 1.0,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  10.0) //                 <--- border radius here
                                              ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            // print('tapped on $index');
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                bottomSheetContents[index]
                                                    .image,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                bottomSheetContents[index]
                                                    .title,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 70, 56, 57),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        elevation: 0,
      ),
      /*
          SHEET BODY
           */
      body: Column(
        children: <Widget>[
          ///header
          Stack(
            children: [
              Container(
                color: Colors.white,
                height: 160,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  top: 2,
                  bottom: 8,
                  left: 8,
                  right: 8,
                ),
                child: Image.asset(
                  fit: BoxFit.fill,
                  'images/home/backGround.png',
                ),
              ),
              FutureBuilder<WeatherModel>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data!.toJson());
                    return Container(
                      color: Colors.transparent,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 5,
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'images/home/theSun.png',
                              ),
                              const SizedBox(width: 10), // give it width
                              Text(
                                '${snapshot.data!.main!.temp!.toStringAsFixed(0)}°C',
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                  fontSize: 28,
                                  color: Color.fromARGB(255, 70, 56, 57),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            bottom: 5,
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Độ Ẩm',
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 70, 56, 57),
                                ),
                              ),
                              const SizedBox(width: 12), // give it width
                              Text(
                                '${snapshot.data!.main!.humidity!.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 70, 56, 57),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            bottom: 5,
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Vị trí',
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 70, 56, 57),
                                ),
                              ),
                              const SizedBox(width: 26), // give it width
                              Text(
                                snapshot.data!.name.toString().substring(10),
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 70, 56, 57),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  // CircularProgressIndicator()
                  // const Center(child: Text(''))
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            color: const Color.fromARGB(255, 217, 217, 217),
            height: 5,
            // child: Text(HomePage.listHeader[position]),
          ),

          /// tabBar
          Container(
            height: 35,
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HomePage.listHeader.length,
                controller: _controller,
                itemBuilder: (con, index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      position = index;
                      topHeader = HomePage.listHeader[index];
                    }),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 24,
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  HomePage.listHeader[index],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    letterSpacing: 0.1,
                                    wordSpacing: 1.0,
                                    color: topHeader ==
                                            HomePage.listHeader[index]
                                        ? const Color.fromARGB(255, 70, 56, 57)
                                        : const Color.fromARGB(
                                            255, 163, 155, 156),
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(height: 1),
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        topHeader == HomePage.listHeader[index]
                                            ? Colors.green
                                            : Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                              ), //             <--- BoxDecoration here
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),

          ///Widget
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails start) {
                // print('start : ${start.velocity.pixelsPerSecond.dx}');
                if ((start.velocity.pixelsPerSecond.dx) < -100) {
                  if (position < HomePage.listHeader.length - 1 &&
                      position >= 0) {
                    setState(() {
                      position = position + 1;
                    });
                  }
                } else {}
                if ((start.velocity.pixelsPerSecond.dx) > 100) {
                  if (position <= HomePage.listHeader.length - 1 &&
                      position > 0) {
                    setState(() {
                      position = position - 1;
                    });
                  }
                }
                // print(position);
              },
              child: applyWidget(),
            ),
          ),
        ],
      ),
    );
  }

  list() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (var color in Colors.primaries)
            Container(color: color, height: 100.0)
        ],
      ),
    );
  }

  grid() {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      children: Colors.primaries.map((color) {
        return Container(color: color, height: 50.0);
      }).toList(),
    );
    // );
  }
}
