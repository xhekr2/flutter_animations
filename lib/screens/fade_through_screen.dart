import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class _MenuModel {
  final IconData icon, activeIcon;
  final String text;

  const _MenuModel({
    required this.icon,
    required this.text,
    required this.activeIcon,
  });
}

const _menuModels = <_MenuModel>[
  _MenuModel(
    icon: Icons.person_outline,
    text: 'Profile',
    activeIcon: Icons.person,
  ),
  _MenuModel(
    icon: Icons.notifications_outlined,
    text: 'Notifications',
    activeIcon: Icons.notifications,
  ),
  _MenuModel(
    icon: Icons.settings_outlined,
    text: 'Settings',
    activeIcon: Icons.settings,
  ),
];

class FadeThroughScreen extends StatefulWidget {
  const FadeThroughScreen({super.key});

  @override
  State<FadeThroughScreen> createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fade Through'), centerTitle: true),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
              fillColor: Colors.white,
            ),
        child: <Widget>[
          for (final _MenuModel model in _menuModels)
            NavigationPage(
              text: model.text,
              iconData: model.activeIcon,
              key: UniqueKey(),
            ),
        ][_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int i) => setState(() {
          _index = _index != i ? i : _index;
        }),
        items: <BottomNavigationBarItem>[
          for (final _MenuModel menu in _menuModels)
            BottomNavigationBarItem(
              activeIcon: Icon(menu.activeIcon),
              icon: Icon(menu.icon),
              label: menu.text,
            ),
        ],
      ),
    );
  }
}

class NavigationPage extends StatelessWidget {
  final String text;
  final IconData iconData;

  const NavigationPage({super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 48),
            Text(text, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
