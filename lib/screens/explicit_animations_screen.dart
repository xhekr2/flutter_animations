import 'dart:async';

import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  bool _repeatReverse = false;

  late final AnimationController _controller;

  // late final Animation<Color?> _color;
  late final Animation<Decoration> _decoration;

  late final Animation<double> _rotation;
  late final Animation<double> _scale;
  late final Animation<Offset> _position;
  late final Animation<double> _animation;

  late final CurvedAnimation _curve;

  final ValueNotifier<double> _value = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    // Ticker((elapsed) => print(elapsed)).start();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(
            () => _value.value = _controller.value,
          ) /*..addListener(() => setState(() {}));*/
    /*..addStatusListener((status) {
            if (status.isCompleted) {
              _controller.reverse();
            } else if (status.isDismissed) {
              _controller.forward();
            }
          })*/
    ;

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticOut,
    );

    // _color = ColorTween(
    //   begin: Colors.amber,
    //   end: Colors.red,
    // ).animate(_controller);
    //  ------------------------
    // // _color = Tween<Color>(
    // //   begin: Colors.amber,
    // //   end: Colors.red,
    // // ).animate(_controller);

    _decoration = DecorationTween(
      begin: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(0),
      ),
      end: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.red,
      ),
    ).animate(_curve);
    // ------------------------------------------------
    // _decoration = Tween<BoxDecoration>(
    //   begin: BoxDecoration(
    //     color: Colors.amber,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   end: BoxDecoration(
    //     borderRadius: BorderRadius.circular(120),
    //     color: Colors.red,
    //   ),
    // ).animate(_controller);

    _rotation = Tween<double>(begin: 0.0, end: 0.25).animate(_curve);
    _scale = Tween<double>(begin: 1.0, end: 1.2).animate(_curve);
    _position = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -0.2),
    ).animate(_curve);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_curve);

    // Timer.periodic(
    //   Duration(milliseconds: 100),
    //   (timer) => print(_controller.value),
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Explicit Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedBuilder(
            //   animation: _color,
            //   // animation: _controller,
            //   builder: (context, child) {
            //     // return Opacity(
            //     //   opacity: _controller.value,
            //     //   child: Container(
            //     //     decoration: BoxDecoration(color: Colors.amber),
            //     //     width: 250,
            //     //     height: 250,
            //     //   ),
            //     // );
            //     return Container(
            //       decoration: BoxDecoration(color: _color.value),
            //       width: 250,
            //       height: 250,
            //     );
            //   },
            // ),
            //
            SlideTransition(
              position: _position,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                    decoration: _decoration,
                    child: Container(
                      width: size.width * 0.8,
                      height: size.width * 0.8,
                    ),
                  ),
                ),
              ),
            ),
            // DecoratedBoxTransition(
            //   decoration: _decoration,
            //   child: AnimatedBuilder(
            //     animation: _animation,
            //     builder: (context, child) => Container(
            //       transformAlignment: Alignment.center,
            //       width: size.width * 0.8,
            //       height: size.width * 0.8,
            //       transform: Matrix4.rotationZ(_animation.value), //???왜 안돼..ㅠㅠ
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30),
            Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () => _controller.forward(),
                      child: Text('Forward'),
                    ),
                    ElevatedButton(
                      onPressed: () => _controller.stop(),
                      child: Text('Stop'),
                    ),
                    ElevatedButton(
                      onPressed: () => _controller.reverse(),
                      child: Text('Reverse'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () => _controller.reset(),
                      child: Text('Reset'),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      child: Row(
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _controller.repeat(reverse: _repeatReverse),
                            child: Text('Repeat'),
                          ),
                          ElevatedButton(
                            onPressed: () => setState(() {
                              _repeatReverse = !_repeatReverse;
                            }),
                            child: Text(
                              _repeatReverse
                                  ? 'repeat.reverse = false'
                                  : 'repeat.reverse = true',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _value,
              builder: (context, value, child) {
                return Slider(
                  value: _value.value,
                  onChanged: (value) {
                    _controller.value = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
