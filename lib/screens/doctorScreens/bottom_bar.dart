import 'package:CarePay/screens/doctorScreens/suppport.dart';
import 'package:flutter/material.dart';
import '../../res/color.dart';
import 'homeMain.dart';
import 'news.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({Key? key}) : super(key: key);

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    homeMain(),
    newsScreen(),
    // supportScreen(),
    // const profileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: Color(0xffEA6B0C),
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'DM Sans',
              fontSize: 10 * fem,
              color: Color(0xffEA6B0C)),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 10 * fem,
          ),
          // unselectedItemColor: Color(0xff00000066),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/unselectedHome.png'),
              activeIcon: Image.asset('assets/images/home.png'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/news.png'),
                activeIcon: Image.asset('assets/images/selectedNews.png'),
                // icon: Icon(Icons.newspaper),
                label: 'News'),
            //       BottomNavigationBarItem( icon: Image.asset('assets/images/callSupport.png',),activeIcon: Image.asset('assets/images/selectedChatSupport.png'),
            // // icon: Icon(Icons.support_agent),
            // label: 'Support')
          ],
        ),
      ),
    );
  }
}
