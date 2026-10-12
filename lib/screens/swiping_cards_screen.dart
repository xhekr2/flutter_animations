import 'dart:math';

import 'package:flutter/material.dart';

import '../data/data_file.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Tween<double> _rotate;
  late final Tween<double> _scale;

  int _index = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
      lowerBound: (deviceWidth + 100) * -1,
      upperBound: (deviceWidth + 100),
      value: 0,
    );

    _rotate = Tween<double>(begin: -15, end: 15);
    _scale = Tween<double>(begin: 0.8, end: 1);
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
      appBar: AppBar(title: Text('Swiping Cards'), centerTitle: true),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final double rotate = _rotate.transform(
            (_controller.value + (size.width / 2)) / size.width,
          );
          final double scale = _scale.transform(
            _controller.value.abs() / size.width,
          );
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: min(scale, 1.0),
                  child: SwipingCard(
                    index: (_index + 1) % colorEnumList.length,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: Transform.translate(
                  offset: Offset(_controller.value, 0),
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) =>
                        _controller.value += details.delta.dx,
                    onHorizontalDragEnd: (details) {
                      final double bound = size.width - 150;
                      final double dropZone = size.width + 100;

                      if (_controller.value.abs() >= bound) {
                        final int factor = _controller.value.isNegative
                            ? -1
                            : 1;
                        _controller
                            .animateTo(
                              dropZone * factor,
                              curve: Curves.elasticOut,
                            )
                            .whenComplete(_whenComplete);
                      } else {
                        _controller.animateTo(0, curve: Curves.elasticOut);
                      }
                    },
                    child: Transform.rotate(
                      angle: rotate * pi / 180,
                      child: SwipingCard(index: _index),
                      // Material(
                      //   elevation: 10,
                      //   color: Colors.red.shade100,
                      //   child: SizedBox(
                      //     width: size.width * 0.8,
                      //     height: size.height * 0.5,
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _whenComplete() => setState(() {
    _controller.value = 0;
    _index = (_index + 1) % colorEnumList.length;
  });
}

class const SwipingCard({super.key, required final int index})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      color: colorEnumList[index].color,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(width: size.width * 0.8, height: size.height * 0.6),
    );
  }
}
