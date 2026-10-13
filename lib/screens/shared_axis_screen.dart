import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/data/data_file.dart';

class SharedAxisScreen extends StatefulWidget {
  const SharedAxisScreen({super.key});

  @override
  State<SharedAxisScreen> createState() => _SharedAxisScreenState();
}

class _SharedAxisScreenState extends State<SharedAxisScreen> {
  int _current = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Axis'), centerTitle: true),
      body: Column(
        spacing: 50,
        children: [
          PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                SharedAxisTransition(
                  fillColor: Colors.white,
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.scaled,
                  child: child,
                ),
            child: Container(
              key: UniqueKey(),
              decoration: BoxDecoration(
                color: colorEnumList[_current - 1 % colorEnumList.length].color,
                shape: BoxShape.circle,
              ),
              width: deviceWidth * 0.8,
              height: deviceWidth * 0.8,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 1; i <= 5; i++)
                ElevatedButton(
                  onPressed: () => setState(() {
                    _current = _current != i ? i : _current;
                  }),
                  child: Text('$i'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
