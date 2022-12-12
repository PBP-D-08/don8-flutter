import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/pages/leaderboard.dart/leaderboard_page.dart';
import 'package:don8_flutter/pages/saved/saved.dart';
import 'package:flutter/material.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:don8_flutter/widgets/drawer.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'homepage/home.dart';
import 'supportmsg/support.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  static const List<Widget> _nonUserOptions = <Widget>[
    Home(),
    Text("Coming soon"),
    LeaderboardPage(),
  ];

  static const List<Widget> _userOptions = <Widget>[
    Home(),
    SavedPage(),
    ShowMessage(),
    LeaderboardPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    User? user = getUser(request);

    return Scaffold(
      appBar: AppBar(
        title: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 40,
                width: 40,
                alignment: Alignment.center,
              ),
            ),
            const Text("don8"),
          ],
        ),
      ),
      drawer: const DrawerApp(),
      body: Container(
          child: request.loggedIn && user?.role == 1
              ? _userOptions.elementAt(_selectedIndex)
              : _nonUserOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: greenMedium,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          if (request.loggedIn && user?.role == 1)
            const BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Saved',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Messages',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: brokenWhite,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
