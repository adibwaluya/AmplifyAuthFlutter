import 'package:aws_auth/feed/feed_page.dart';
import 'package:aws_auth/inbox/inbox_page.dart';
import 'package:aws_auth/plan/plan_page.dart';
import 'package:aws_auth/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final screens = [
    //const FeedPage(),
    const PlanPage(),
    const InboxPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
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
