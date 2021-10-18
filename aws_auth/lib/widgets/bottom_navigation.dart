import 'package:aws_auth/auth/auth_service.dart';
import 'package:aws_auth/feed/feed_page.dart';
import 'package:aws_auth/inbox/inbox_page.dart';
import 'package:aws_auth/plan/plan_page.dart';
import 'package:aws_auth/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class BottomNavigation extends StatefulWidget {
  final VoidCallback shouldLogOut;
  const BottomNavigation({Key? key, required this.shouldLogOut})
      : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final _authService = AuthService();
  late final String jwt;
  late final Map<String, dynamic> payload;
  int _currentIndex = 0;

  List<Widget> get _pages {
    return [
      // Show Feed Page
      FeedPage(jwt, payload),

      // Show Plan Page
      const PlanPage(),

      // Inbox Page
      const InboxPage(),

      // Profile Page
      const ProfilePage(),
    ];
  }

/*
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return FeedPage(shouldLogOut: _authService.logOut);
      case 1:
        return PlanPage();
      case 2:
        return InboxPage();
      case 3:
        return ProfilePage();
      default:
        return FeedPage(shouldLogOut: _authService.logOut);
    }
  }
  */

  /*
  final screens = [
    const FeedPage(),
    const PlanPage(),
    const InboxPage(),
    const ProfilePage(),
  ];
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: darkPurpleColor,
          unselectedItemColor: whiteColor,
          selectedFontSize: 0,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: '',
              backgroundColor: lightPurpleColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.checklist),
              label: '',
              backgroundColor: lightPurpleColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat),
              label: '',
              backgroundColor: lightPurpleColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: '',
              backgroundColor: lightPurpleColor,
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
