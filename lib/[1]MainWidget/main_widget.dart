import 'package:flutter/material.dart';
import 'package:viis_pyriot/[2]Home/home.dart';
import 'package:viis_pyriot/[3]Notifications/notifications.dart';
import 'package:viis_pyriot/[4]Search/search.dart';
import 'package:viis_pyriot/%5B5%5DUser/user.dart';

const double iConSize = 26;

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  // This widget is the root of your application.
  int currentNavigationIndex = 0;

  final tabs = [
    const Center(child: HomePage()),
    const Center(child: NotificationsPage()),
    const Center(child: SearchPage()),
    const Center(child: UserPage()),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Portfolio manager'),
        // ),
        body: tabs[currentNavigationIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: 'Trang chủ',
              icon: Icon(
                Icons.home,
                // color: Colors.blue,
                size: iConSize,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Tìm kiếm',
              icon: Icon(
                Icons.search,
                // color: Colors.blue,
                size: iConSize,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Thông báo',
              icon: Icon(
                Icons.notifications,
                // color: Colors.blue,
                size: iConSize,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Cá nhân',
              icon: Icon(
                Icons.person,
                // color: Colors.blue,
                size: iConSize,
              ),
            )
          ],
          currentIndex: currentNavigationIndex,
          onTap: (int currentIndex) {
            setState(() {
              currentNavigationIndex = currentIndex;
            });
          },
        ),
      ),
    );
  }
}

void widgetCallBack(BuildContext context, Widget pages) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => pages,
    ),
  );
}
