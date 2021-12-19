import 'package:astrotak/screens/astologerlist/astrologerlistpage.dart';
import 'package:astrotak/screens/panchang/panchangpage.dart';
import 'package:astrotak/utils/appconstants.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
  String? filter;
  static bool flag = false;
  int currentIndexDashBoard = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print("MainPage initiated");

    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/logo.png',width: 50,height: 50,),
        elevation: 0.0,
        leading: Image.asset('assets/images/hamburger.png'),
        actions: <Widget>[
         Image.asset('assets/images/profile.png',width: 30,height: 30,),
          const SizedBox(width: 10,)
        ],
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexDashBoard,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            filter = null;
            currentIndexDashBoard = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/home.png',
              color:  Colors.red,
              height: bottomIconHeight,
              width: bottomIconHeight,
            ),
            icon: Image.asset(
              'assets/images/home.png',
              color: Colors.grey,
              height: bottomIconHeight,
              width: bottomIconHeight,
            ),
            label: 'Home',),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                'assets/images/talk.png',
                color:  Colors.red,
                height: bottomIconHeight,
                width: bottomIconHeight,
              ),
              icon: Image.asset(
                'assets/images/talk.png',
                color: Colors.grey,
                height: bottomIconHeight,
                width: bottomIconHeight,
              ),
//            backgroundColor: Colors.green,
              label: 'Talk to Astrolger'),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/ask.png',
              color:  Colors.red,
              height: bottomIconHeight,
              width: bottomIconHeight,
            ),
            icon: Image.asset(
              'assets/images/ask.png',
              color: Colors.grey,
              height: bottomIconHeight,
              width: bottomIconHeight,
            ),
            label: 'Ask Questions',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/reports.png',
              color: Colors.red,
              height: bottomIconHeight,
              width: bottomIconHeight,

            ),
            icon: Image.asset(
              'assets/images/reports.png',
              color: Colors.grey,
              height: bottomIconHeight,
              width: bottomIconHeight,
            ),
            label: 'Reports',
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget? getBody() {
    switch (currentIndexDashBoard) {
      case 0:
        return PanchangPage();
      case 1:
        return AstrologerListPage();
      case 2:
        return Container();
      case 3:
        return Container();
    }
  }



  @override
  void dispose() {
    super.dispose();
  }
}
