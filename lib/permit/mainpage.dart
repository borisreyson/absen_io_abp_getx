import 'package:face_id_plus/permit/page/home_page.dart';
import 'package:face_id_plus/permit/page/news.dart';
import 'package:face_id_plus/permit/page/profile.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Color> _colorList = [
    const Color(0xFFD8C7FF),
    const Color(0xffD3EDD2),
    const Color(0xFF7F3236)
  ];
  List<Color> textColors = [
    const Color.fromARGB(255, 243, 242, 242),
    Colors.white,
    Colors.white
  ];
  List<Color> iconColors = [
    const Color(0xFF7C6B9C),
    const Color(0xff64926D),
    const Color(0xFF732937)
  ];
  final List<Widget> _listPage = [
    const HomePage(),
    const News(),
    const Profile()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_rounded,
              size: 30,
              color: iconColors.elementAt(_selectedIndex),
            ),
          )
        ],
        toolbarHeight: 80,
        leadingWidth: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          elevation: 4,
          margin: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(13.0),
              child: Image(
                image: AssetImage("assets/ic_abp.png"),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: _colorList.elementAt(_selectedIndex),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          _listPage.elementAt(_selectedIndex),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }

  Widget navigasi() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: const TextStyle(color: Colors.black),
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: textColors.elementAt(_selectedIndex),
          ),
          label: 'Home',
          backgroundColor: iconColors.elementAt(_selectedIndex),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper_rounded,
            color: textColors.elementAt(_selectedIndex),
          ),
          label: 'News',
          backgroundColor: iconColors.elementAt(_selectedIndex),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline_rounded,
            color: textColors.elementAt(_selectedIndex),
          ),
          label: 'Profile',
          backgroundColor: iconColors.elementAt(_selectedIndex),
        )
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
