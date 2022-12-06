import 'package:flutter/material.dart';
import 'package:viis_pyriot/%5B1%5DMainWidget/main_widget.dart';
import 'content_model.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: contents.length,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, i) {
              // print("Current page $i");
              return SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(contents[i].image),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 420,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(contents[currentIndex].slider),
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 475,
            child: Container(
              color: Colors.transparent,
              height: 210,
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 5,
                      left: 50,
                      right: 50,
                    ),
                    child: Text(
                      contents[currentIndex].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 0, 0, 9),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 30,
                      right: 30,
                    ),
                    child: Text(
                      contents[currentIndex].discription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 5,
                        left: 50,
                        right: 50,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 68, 196, 161),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(currentIndex == contents.length - 1
                            ? "Bắt đầu trải nghiệm"
                            : "Tiếp tục"),
                        onPressed: () {
                          if (currentIndex < contents.length - 1) {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.bounceIn,
                            );
                          }
                          if (currentIndex == 3) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MainWidget(),
                              ),
                            );
                          }
                        },
                      ))
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
