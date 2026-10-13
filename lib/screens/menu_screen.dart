import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/custom_painter_screen.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/music_player_screen.dart';
import 'package:flutter_animations_masterclass/screens/shared_axis_screen.dart';
import 'package:flutter_animations_masterclass/screens/swiping_cards_screen.dart';

import 'container_transform_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Animations')),
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigatorPush(context, ImplicitAnimationsScreen());
              },
              child: Text('Implicit Animations'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigatorPush(context, ExplicitAnimationsScreen());
              },
              child: Text('Explicit Animations'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigatorPush(context, CustomPainterScreen());
              },
              child: Text('CustomPainter'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigatorPush(context, SwipingCardsScreen());
              },
              child: Text('Swiping Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigatorPush(context, MusicPlayerScreen());
              },
              child: Text('Music Player'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigatorPush(context, ContainerTransformScreen());
              },
              child: Text('Container Transform'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigatorPush(context, SharedAxisScreen());
              },
              child: Text('Shared Axis'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigatorPush(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }
}
